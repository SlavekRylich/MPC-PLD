# 2026-04-24T10:03:24.251497700
import vitis

client = vitis.create_client()
client.set_workspace(path="WORKSPACE_VITIS")

platform = client.create_platform_component(name = "rf_platform",hw_design = "$COMPONENT_LOCATION/../../SOURCES/HW/rp_microblaze.xsa",os = "standalone",cpu = "microblaze_I",domain_name = "standalone_microblaze_I",compiler = "gcc")

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../rf_platform/export/rf_platform/rf_platform.xpfm",domain = "standalone_microblaze_I",template = "hello_world")

platform = client.get_component(name="rf_platform")
status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

status = platform.build()

status = platform.build()

comp.build()

domain = platform.get_domain(name="standalone_microblaze_I")

status = domain.set_config(option = "os", param = "standalone_stdin", value = "iomodule_0")

status = domain.set_config(option = "os", param = "standalone_stdout", value = "iomodule_0")

status = platform.build()

status = platform.build()

comp.build()

status = comp.clean()

status = platform.build()

comp.build()

status = comp.clean()

status = platform.build()

comp.build()

client.delete_component(name="rf_platform")

client.delete_component(name="componentName")

client.delete_component(name="hello_world")

client.delete_component(name="componentName")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../SOURCES/HW/rp_microblaze.xsa",os = "standalone",cpu = "microblaze_I",domain_name = "standalone_microblaze_I",compiler = "gcc")

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_microblaze_I",template = "hello_world")

platform = client.get_component(name="platform")
status = platform.build()

comp.build()

status = comp.clean()

status = platform.build()

comp.build()

client.delete_component(name="platform")

client.delete_component(name="platform")

client.delete_component(name="hello_world")

vitis.dispose()

