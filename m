From: Jun Chen <jun.d.chen@intel.com>
Subject: Re: [PATCH] serial: ifx6x60: Add modem power off function in the
 platform reboot process
Date: Fri, 23 Nov 2012 06:14:14 -0500
Message-ID: <1353669254.23300.16.camel@chenjun-workstation>
References: <1353583163.23300.7.camel@chenjun-workstation>
	 <20121122110857.2f7c9804@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:9644 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758923Ab2KWDL0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Nov 2012 22:11:26 -0500
In-Reply-To: <20121122110857.2f7c9804@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Bi Chao <chao.bi@intel.com>, serial <linux-serial@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>

On Thu, 2012-11-22 at 11:08 +0000, Alan Cox wrote:
> On Thu, 22 Nov 2012 06:19:23 -0500
> Jun Chen <jun.d.chen@intel.com> wrote:
> 
> > 
> > This patch add modem power off function in the reboot process
> > according registering reboot callback to the reboot_notifier_list.
> > Also realizing the spi shutdown function.
> 
> Need to unregister the reboot notifier in the ifx_spi_exit path. If the
> driver module is unloaded you leave the callback present and the kernel
> will call into freed memory.
> 
> Alan
Yes,thanks! I will update this patch again.

