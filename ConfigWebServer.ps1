configuration IISConfig
{
	# Importa os módulos necessários
    Import-DscResource –Module xWebAdministration
	Import-DscResource -ModuleName PsDesiredStateConfiguration
	
    node "localhost"
     {
        # Instala o IIS com os componentes padrão
		WindowsFeature IIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }
		
		# Instala o console de Gerenciamento do IIS
        WindowsFeature MgmtConsole
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Tools"
            DependsOn = "[WindowsFeature]IIS"
        }

        # Cria a pasta do site que será criado
		File SitePhysicalFolder
        {
            Ensure = "Present"
            Type = "Directory"            
            DestinationPath = "C:\inetpub\DefaultSite" 
            DependsOn = "[WindowsFeature]IIS"                       
        }
	
        # Cria a home page do site
		File HomePage
        {
            Ensure = "Present"
            Type = "File"
            Recurse = $true
            DestinationPath = "C:\inetpub\DefaultSite\index.htm"
            Contents = "<html><h1>Hello World!</h1></html>"
            DependsOn = "[File]SitePhysicalFolder"
        }
            
        # Remove o  site padrão do IIS
		xWebsite DefaultWebSite
        {
            Ensure = "Absent"
            Name = "Default Web Site"            
            PhysicalPath = "C:\inetpub\wwwroot"
            DependsOn = "[WindowsFeature]IIS"
        }
        
		# Cria um novo site do IIS
		xWebsite NewWebSite
        {
            Ensure = "Present"
            Name = "Web Site 1"            
            PhysicalPath = "C:\inetpub\DefaultSite"
            DependsOn = "[File]HomePage"
        }
    }
}
IISConfig