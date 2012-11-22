From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: ifx6x60: Add modem power off function in the
 platform reboot process
Date: Thu, 22 Nov 2012 11:08:57 +0000
Message-ID: <20121122110857.2f7c9804@bob.linux.org.uk>
References: <1353583163.23300.7.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353583163.23300.7.camel@chenjun-workstation>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: Bi Chao <chao.bi@intel.com>, serial <linux-serial@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 22 Nov 2012 06:19:23 -0500
Jun Chen <jun.d.chen@intel.com> wrote:

> 
> This patch add modem power off function in the reboot process
> according registering reboot callback to the reboot_notifier_list.
> Also realizing the spi shutdown function.

Need to unregister the reboot notifier in the ifx_spi_exit path. If the
driver module is unloaded you leave the callback present and the kernel
will call into freed memory.

Alan
