import uuid

def generate_id():
    return uuid.uuid4().hex[:24].upper()

# Fixed deterministic IDs for clarity and stability
proj_id = "010000000000000000000001"
main_group_id = "010000000000000000000002"
products_group_id = "010000000000000000000003"
app_group_id = "010000000000000000000004"
keyboard_group_id = "010000000000000000000005"
shared_group_id = "010000000000000000000006"
app_views_group_id = "010000000000000000000007"
kb_views_group_id = "010000000000000000000008"

# Product file references
app_product_ref = "020000000000000000000001"
kb_product_ref = "020000000000000000000002"

# Targets
app_target_id = "030000000000000000000001"
kb_target_id = "030000000000000000000002"

# File references & Build files
# Shared files:
# 1. ClipItem.swift
f_clipitem_ref = "040000000000000000000001"
b_clipitem_app = "050000000000000000000001"
b_clipitem_kb  = "050000000000000000000002"

# 2. AppConfig.swift
f_appconfig_ref = "040000000000000000000002"
b_appconfig_app = "050000000000000000000003"
b_appconfig_kb  = "050000000000000000000004"

# 3. ClipboardStore.swift
f_store_ref = "040000000000000000000003"
b_store_app = "050000000000000000000005"
b_store_kb  = "050000000000000000000006"

# App files:
# 4. ClipboardApp.swift
f_app_swift_ref = "040000000000000000000010"
b_app_swift     = "050000000000000000000010"

# 5. MainView.swift
f_mainview_ref  = "040000000000000000000011"
b_mainview      = "050000000000000000000011"

# 6. ClipRowView.swift
f_rowview_ref   = "040000000000000000000012"
b_rowview       = "050000000000000000000012"

# 7. AddEditClipSheet.swift
f_addsheet_ref  = "040000000000000000000013"
b_addsheet      = "050000000000000000000013"

# 8. SetupGuideView.swift
f_guideview_ref = "040000000000000000000014"
b_guideview     = "050000000000000000000014"

# 9. TestKeyboardAreaView.swift
f_testview_ref  = "040000000000000000000015"
b_testview      = "050000000000000000000015"

# 10. SettingsView.swift
f_settings_ref  = "040000000000000000000016"
b_settings      = "050000000000000000000016"

# 11. Assets.xcassets (App)
f_app_assets_ref = "040000000000000000000017"
b_app_assets     = "050000000000000000000017"

# 12. Info.plist & entitlements
f_app_info_ref   = "040000000000000000000018"
f_app_entit_ref  = "040000000000000000000019"

# Keyboard files:
# 13. KeyboardViewController.swift
f_kb_controller_ref = "040000000000000000000020"
b_kb_controller     = "050000000000000000000020"

# 14. KeyboardRootView.swift
f_kb_root_ref       = "040000000000000000000021"
b_kb_root           = "050000000000000000000021"

# 15. KeyboardToolbar.swift
f_kb_toolbar_ref    = "040000000000000000000022"
b_kb_toolbar        = "050000000000000000000022"

# 16. ClipCardView.swift
f_kb_card_ref       = "040000000000000000000023"
b_kb_card           = "050000000000000000000023"

# 17. Assets.xcassets (Keyboard)
f_kb_assets_ref     = "040000000000000000000024"
b_kb_assets         = "050000000000000000000024"

# 18. Info.plist & entitlements
f_kb_info_ref       = "040000000000000000000025"
f_kb_entit_ref      = "040000000000000000000026"

# Embed Appex Build file
b_embed_kb_appex    = "050000000000000000000030"

# Build Phases
app_sources_id   = "060000000000000000000001"
app_resources_id = "060000000000000000000002"
app_frameworks_id= "060000000000000000000003"
app_embed_id     = "060000000000000000000004"

kb_sources_id    = "060000000000000000000005"
kb_resources_id  = "060000000000000000000006"
kb_frameworks_id = "060000000000000000000007"

# Container Item Proxy & Target Dependency
kb_target_proxy_id = "070000000000000000000001"
kb_dependency_id   = "070000000000000000000002"

# Configuration Lists & Configurations
proj_cfg_list   = "080000000000000000000001"
proj_debug_cfg  = "080000000000000000000002"
proj_rel_cfg    = "080000000000000000000003"

app_cfg_list    = "080000000000000000000004"
app_debug_cfg   = "080000000000000000000005"
app_rel_cfg     = "080000000000000000000006"

kb_cfg_list     = "080000000000000000000007"
kb_debug_cfg    = "080000000000000000000008"
kb_rel_cfg      = "080000000000000000000009"

pbx = f"""// !$*UTF8*$!
{{
	archiveVersion = 1;
	classes = {{
	}};
	objectVersion = 56;
	objects = {{

/* Begin PBXBuildFile section */
		{b_clipitem_app} /* ClipItem.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_clipitem_ref} /* ClipItem.swift */; }};
		{b_clipitem_kb} /* ClipItem.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_clipitem_ref} /* ClipItem.swift */; }};
		{b_appconfig_app} /* AppConfig.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_appconfig_ref} /* AppConfig.swift */; }};
		{b_appconfig_kb} /* AppConfig.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_appconfig_ref} /* AppConfig.swift */; }};
		{b_store_app} /* ClipboardStore.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_store_ref} /* ClipboardStore.swift */; }};
		{b_store_kb} /* ClipboardStore.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_store_ref} /* ClipboardStore.swift */; }};

		{b_app_swift} /* ClipboardApp.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_app_swift_ref} /* ClipboardApp.swift */; }};
		{b_mainview} /* MainView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_mainview_ref} /* MainView.swift */; }};
		{b_rowview} /* ClipRowView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_rowview_ref} /* ClipRowView.swift */; }};
		{b_addsheet} /* AddEditClipSheet.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_addsheet_ref} /* AddEditClipSheet.swift */; }};
		{b_guideview} /* SetupGuideView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_guideview_ref} /* SetupGuideView.swift */; }};
		{b_testview} /* TestKeyboardAreaView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_testview_ref} /* TestKeyboardAreaView.swift */; }};
		{b_settings} /* SettingsView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_settings_ref} /* SettingsView.swift */; }};
		{b_app_assets} /* Assets.xcassets in Resources */ = {{isa = PBXBuildFile; fileRef = {f_app_assets_ref} /* Assets.xcassets */; }};

		{b_kb_controller} /* KeyboardViewController.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_kb_controller_ref} /* KeyboardViewController.swift */; }};
		{b_kb_root} /* KeyboardRootView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_kb_root_ref} /* KeyboardRootView.swift */; }};
		{b_kb_toolbar} /* KeyboardToolbar.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_kb_toolbar_ref} /* KeyboardToolbar.swift */; }};
		{b_kb_card} /* ClipCardView.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {f_kb_card_ref} /* ClipCardView.swift */; }};
		{b_kb_assets} /* Assets.xcassets in Resources */ = {{isa = PBXBuildFile; fileRef = {f_kb_assets_ref} /* Assets.xcassets */; }};

		{b_embed_kb_appex} /* ClipboardKeyboard.appex in Embed App Extensions */ = {{isa = PBXBuildFile; fileRef = {kb_product_ref} /* ClipboardKeyboard.appex */; settings = {{ATTRIBUTES = (RemoveHeadersOnCopy, ); }}; }};
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
		{kb_target_proxy_id} /* PBXContainerItemProxy */ = {{
			isa = PBXContainerItemProxy;
			containerPortal = {proj_id} /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = {kb_target_id};
			remoteInfo = ClipboardKeyboard;
		}};
/* End PBXContainerItemProxy section */

/* Begin PBXCopyFilesBuildPhase section */
		{app_embed_id} /* Embed App Extensions */ = {{
			isa = PBXCopyFilesBuildPhase;
			buildActionMask = 2147483647;
			dstPath = "";
			dstSubfolderSpec = 13;
			files = (
				{b_embed_kb_appex} /* ClipboardKeyboard.appex in Embed App Extensions */,
			);
			name = "Embed App Extensions";
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXCopyFilesBuildPhase section */

/* Begin PBXFileReference section */
		{app_product_ref} /* ClipboardApp.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = ClipboardApp.app; sourceTree = BUILT_PRODUCTS_DIR; }};
		{kb_product_ref} /* ClipboardKeyboard.appex */ = {{isa = PBXFileReference; explicitFileType = "wrapper.app-extension"; includeInIndex = 0; path = ClipboardKeyboard.appex; sourceTree = BUILT_PRODUCTS_DIR; }};

		{f_clipitem_ref} /* ClipItem.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ClipItem.swift; sourceTree = "<group>"; }};
		{f_appconfig_ref} /* AppConfig.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppConfig.swift; sourceTree = "<group>"; }};
		{f_store_ref} /* ClipboardStore.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ClipboardStore.swift; sourceTree = "<group>"; }};

		{f_app_swift_ref} /* ClipboardApp.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ClipboardApp.swift; sourceTree = "<group>"; }};
		{f_mainview_ref} /* MainView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = MainView.swift; sourceTree = "<group>"; }};
		{f_rowview_ref} /* ClipRowView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ClipRowView.swift; sourceTree = "<group>"; }};
		{f_addsheet_ref} /* AddEditClipSheet.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AddEditClipSheet.swift; sourceTree = "<group>"; }};
		{f_guideview_ref} /* SetupGuideView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SetupGuideView.swift; sourceTree = "<group>"; }};
		{f_testview_ref} /* TestKeyboardAreaView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestKeyboardAreaView.swift; sourceTree = "<group>"; }};
		{f_settings_ref} /* SettingsView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SettingsView.swift; sourceTree = "<group>"; }};
		{f_app_assets_ref} /* Assets.xcassets */ = {{isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; }};
		{f_app_info_ref} /* Info.plist */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; }};
		{f_app_entit_ref} /* ClipboardApp.entitlements */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = ClipboardApp.entitlements; sourceTree = "<group>"; }};

		{f_kb_controller_ref} /* KeyboardViewController.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = KeyboardViewController.swift; sourceTree = "<group>"; }};
		{f_kb_root_ref} /* KeyboardRootView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = KeyboardRootView.swift; sourceTree = "<group>"; }};
		{f_kb_toolbar_ref} /* KeyboardToolbar.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = KeyboardToolbar.swift; sourceTree = "<group>"; }};
		{f_kb_card_ref} /* ClipCardView.swift */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ClipCardView.swift; sourceTree = "<group>"; }};
		{f_kb_assets_ref} /* Assets.xcassets */ = {{isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; }};
		{f_kb_info_ref} /* Info.plist */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; }};
		{f_kb_entit_ref} /* ClipboardKeyboard.entitlements */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = ClipboardKeyboard.entitlements; sourceTree = "<group>"; }};
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		{app_frameworks_id} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
		{kb_frameworks_id} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		{main_group_id} = {{
			isa = PBXGroup;
			children = (
				{shared_group_id} /* Shared */,
				{app_group_id} /* ClipboardApp */,
				{keyboard_group_id} /* ClipboardKeyboard */,
				{products_group_id} /* Products */,
			);
			sourceTree = "<group>";
		}};
		{products_group_id} /* Products */ = {{
			isa = PBXGroup;
			children = (
				{app_product_ref} /* ClipboardApp.app */,
				{kb_product_ref} /* ClipboardKeyboard.appex */,
			);
			name = Products;
			sourceTree = "<group>";
		}};
		{shared_group_id} /* Shared */ = {{
			isa = PBXGroup;
			children = (
				{f_clipitem_ref} /* ClipItem.swift */,
				{f_appconfig_ref} /* AppConfig.swift */,
				{f_store_ref} /* ClipboardStore.swift */,
			);
			path = Shared;
			sourceTree = "<group>";
		}};
		{app_group_id} /* ClipboardApp */ = {{
			isa = PBXGroup;
			children = (
				{f_app_swift_ref} /* ClipboardApp.swift */,
				{app_views_group_id} /* Views */,
				{f_app_assets_ref} /* Assets.xcassets */,
				{f_app_info_ref} /* Info.plist */,
				{f_app_entit_ref} /* ClipboardApp.entitlements */,
			);
			path = ClipboardApp;
			sourceTree = "<group>";
		}};
		{app_views_group_id} /* Views */ = {{
			isa = PBXGroup;
			children = (
				{f_mainview_ref} /* MainView.swift */,
				{f_rowview_ref} /* ClipRowView.swift */,
				{f_addsheet_ref} /* AddEditClipSheet.swift */,
				{f_guideview_ref} /* SetupGuideView.swift */,
				{f_testview_ref} /* TestKeyboardAreaView.swift */,
				{f_settings_ref} /* SettingsView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		}};
		{keyboard_group_id} /* ClipboardKeyboard */ = {{
			isa = PBXGroup;
			children = (
				{f_kb_controller_ref} /* KeyboardViewController.swift */,
				{kb_views_group_id} /* Views */,
				{f_kb_assets_ref} /* Assets.xcassets */,
				{f_kb_info_ref} /* Info.plist */,
				{f_kb_entit_ref} /* ClipboardKeyboard.entitlements */,
			);
			path = ClipboardKeyboard;
			sourceTree = "<group>";
		}};
		{kb_views_group_id} /* Views */ = {{
			isa = PBXGroup;
			children = (
				{f_kb_root_ref} /* KeyboardRootView.swift */,
				{f_kb_toolbar_ref} /* KeyboardToolbar.swift */,
				{f_kb_card_ref} /* ClipCardView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		}};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		{app_target_id} /* ClipboardApp */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {app_cfg_list} /* Build configuration list for PBXNativeTarget "ClipboardApp" */;
			buildPhases = (
				{app_sources_id} /* Sources */,
				{app_frameworks_id} /* Frameworks */,
				{app_resources_id} /* Resources */,
				{app_embed_id} /* Embed App Extensions */,
			);
			buildRules = (
			);
			dependencies = (
				{kb_dependency_id} /* PBXTargetDependency */,
			);
			name = ClipboardApp;
			productName = ClipboardApp;
			productReference = {app_product_ref} /* ClipboardApp.app */;
			productType = "com.apple.product-type.application";
		}};
		{kb_target_id} /* ClipboardKeyboard */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {kb_cfg_list} /* Build configuration list for PBXNativeTarget "ClipboardKeyboard" */;
			buildPhases = (
				{kb_sources_id} /* Sources */,
				{kb_frameworks_id} /* Frameworks */,
				{kb_resources_id} /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = ClipboardKeyboard;
			productName = ClipboardKeyboard;
			productReference = {kb_product_ref} /* ClipboardKeyboard.appex */;
			productType = "com.apple.product-type.app-extension";
		}};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		{proj_id} /* Project object */ = {{
			isa = PBXProject;
			attributes = {{
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
				TargetAttributes = {{
					{app_target_id} = {{
						CreatedOnToolsVersion = 15.0;
					}};
					{kb_target_id} = {{
						CreatedOnToolsVersion = 15.0;
					}};
				}};
			}};
			buildConfigurationList = {proj_cfg_list} /* Build configuration list for PBXProject "ClipboardApp" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				ar,
				Base,
			);
			mainGroup = {main_group_id};
			productRefGroup = {products_group_id} /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				{app_target_id} /* ClipboardApp */,
				{kb_target_id} /* ClipboardKeyboard */,
			);
		}};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		{app_resources_id} /* Resources */ = {{
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				{b_app_assets} /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
		{kb_resources_id} /* Resources */ = {{
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				{b_kb_assets} /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		{app_sources_id} /* Sources */ = {{
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				{b_clipitem_app} /* ClipItem.swift in Sources */,
				{b_appconfig_app} /* AppConfig.swift in Sources */,
				{b_store_app} /* ClipboardStore.swift in Sources */,
				{b_app_swift} /* ClipboardApp.swift in Sources */,
				{b_mainview} /* MainView.swift in Sources */,
				{b_rowview} /* ClipRowView.swift in Sources */,
				{b_addsheet} /* AddEditClipSheet.swift in Sources */,
				{b_guideview} /* SetupGuideView.swift in Sources */,
				{b_testview} /* TestKeyboardAreaView.swift in Sources */,
				{b_settings} /* SettingsView.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
		{kb_sources_id} /* Sources */ = {{
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				{b_clipitem_kb} /* ClipItem.swift in Sources */,
				{b_appconfig_kb} /* AppConfig.swift in Sources */,
				{b_store_kb} /* ClipboardStore.swift in Sources */,
				{b_kb_controller} /* KeyboardViewController.swift in Sources */,
				{b_kb_root} /* KeyboardRootView.swift in Sources */,
				{b_kb_toolbar} /* KeyboardToolbar.swift in Sources */,
				{b_kb_card} /* ClipCardView.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
		{kb_dependency_id} /* PBXTargetDependency */ = {{
			isa = PBXTargetDependency;
			target = {kb_target_id} /* ClipboardKeyboard */;
			targetProxy = {kb_target_proxy_id} /* PBXContainerItemProxy */;
		}};
/* End PBXTargetDependency section */

/* Begin XCBuildConfiguration section */
		{proj_debug_cfg} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				IPHONEOS_DEPLOYMENT_TARGET = 16.0;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
			}};
			name = Debug;
		}};
		{proj_rel_cfg} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_OPTIMIZATION_LEVEL = s;
				IPHONEOS_DEPLOYMENT_TARGET = 16.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				SWIFT_VERSION = 5.0;
				VALIDATE_PRODUCT = YES;
			}};
			name = Release;
		}};
		{app_debug_cfg} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_ENTITLEMENTS = ClipboardApp/ClipboardApp.entitlements;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = ClipboardApp/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.clipboard.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			}};
			name = Debug;
		}};
		{app_rel_cfg} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_ENTITLEMENTS = ClipboardApp/ClipboardApp.entitlements;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = ClipboardApp/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.clipboard.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			}};
			name = Release;
		}};
		{kb_debug_cfg} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				CODE_SIGN_ENTITLEMENTS = ClipboardKeyboard/ClipboardKeyboard.entitlements;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = ClipboardKeyboard/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
					"@executable_path/../../Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.clipboard.app.keyboard;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			}};
			name = Debug;
		}};
		{kb_rel_cfg} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				CODE_SIGN_ENTITLEMENTS = ClipboardKeyboard/ClipboardKeyboard.entitlements;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = ClipboardKeyboard/Info.plist;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
					"@executable_path/../../Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.clipboard.app.keyboard;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			}};
			name = Release;
		}};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		{proj_cfg_list} /* Build configuration list for PBXProject "ClipboardApp" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{proj_debug_cfg} /* Debug */,
				{proj_rel_cfg} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
		{app_cfg_list} /* Build configuration list for PBXNativeTarget "ClipboardApp" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{app_debug_cfg} /* Debug */,
				{app_rel_cfg} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
		{kb_cfg_list} /* Build configuration list for PBXNativeTarget "ClipboardKeyboard" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{kb_debug_cfg} /* Debug */,
				{kb_rel_cfg} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
/* End XCConfigurationList section */

	}};
	rootObject = {proj_id} /* Project object */;
}}
"""

with open("ClipboardApp.xcodeproj/project.pbxproj", "w", encoding="utf-8") as f:
    f.write(pbx)

print("Successfully generated ClipboardApp.xcodeproj/project.pbxproj")
