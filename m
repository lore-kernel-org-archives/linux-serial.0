From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Mon, 5 Nov 2012 11:43:29 +0000
Message-ID: <20121105114329.0f60b484@pyramind.ukuu.org.uk>
References: <1351872943.4332.37.camel@chenjun-workstation>
	<20121102112945.535bfea7@pyramind.ukuu.org.uk>
	<9E44E06DBBA23A489DED933DBC291A850FD6FE1F@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39207 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab2KELiX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Nov 2012 06:38:23 -0500
In-Reply-To: <9E44E06DBBA23A489DED933DBC291A850FD6FE1F@SHSMSX102.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Chen, Jun D" <jun.d.chen@intel.com>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Liu, Chuansheng" <chuansheng.liu@intel.com>, "Bi, Chao" <chao.bi@intel.com>

On Mon, 5 Nov 2012 08:26:08 +0000
"Chen, Jun D" <jun.d.chen@intel.com> wrote:

> Hi,Alan
>     Thank your reply and advice. 
> > +	if (reset_request == IFX_COLD_RESET_REQ) {
> > +		/*  Need to add these action for modem cold reset:
> > +		* - Set the RESET_BB_N to low (better SIM protection)
> > +		* - Set the EXT1P35VREN field to low  during 20ms (V1P35CNT_W  register)
> > +		* - set the EXT1P35VREN field to high during 10ms (V1P35CNT_W  register)
> > +		*/
> I want to submit one finished version, but these code need to call the intel_scu_ipc_readv and intel_scu_ipc_writev function defined in the file <asm/intel_scu_ipc.h>
> But this module seem not to be maked. Now I add one macro to disable these functions. I will send the new patch to you and would you like to give more suggestion about this issue.

You probably need your Kconfig entry to have

	depends on X86_INTEL_MID && INTEL_SCU_IPC

so that it can only be compiled when the feature is present.

Alan
