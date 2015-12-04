From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/9] ACPI: Add support for AMBA bus type
Date: Fri, 4 Dec 2015 10:50:23 +0200
Message-ID: <20151204085023.GE1593@lahna.fi.intel.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
 <1449199466-6081-2-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449199466-6081-2-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 04, 2015 at 11:24:18AM +0800, Wang Hongcheng wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> Inspired by acpi platform bus type, to make driver "porting" more
> straightforward, this patch introduces ACPI support to the AMBA bus
> type. Instead of writing ACPI "glue" drivers for the exiting AMBA
> drivers.

Hmm, isn't there already similar patch series bringing AMBA ACPI
support?

https://lkml.org/lkml/2015/9/30/394
