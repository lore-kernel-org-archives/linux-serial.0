From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 8/9] Documentation: Add ivrs_acpihid kernel parameter description
Date: Fri, 4 Dec 2015 11:24:25 +0800
Message-ID: <1449199466-6081-9-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wan Zongshun <Vincent.Wan@amd.com>
List-Id: linux-serial@vger.kernel.org

From: Wan Zongshun <Vincent.Wan@amd.com>

Add ivrs_acpihid kernel parameter description,
like ivrs_acpihid[00:14.5]=AMD0020:0.

Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
---
 Documentation/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 742f69d..5c364c6 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1680,6 +1680,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			PCI device 00:14.0 write the parameter as:
 				ivrs_hpet[0]=00:14.0
 
+	ivrs_acpihid	[HW,X86_64]
+			Provide an override to the ACPI-HID:UID<->DEVICE-ID
+			mapping provided in the IVRS ACPI table. For
+			example, to map UART-HID:UID AMD0020:0 to
+			PCI device 00:14.5 write the parameter as:
+				ivrs_acpihid[00:14.5]=AMD0020:0
+
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joystick.txt.
 
-- 
1.9.1

