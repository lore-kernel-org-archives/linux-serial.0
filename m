From: "Chen, Jun D" <jun.d.chen@intel.com>
Subject: RE: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Tue, 6 Nov 2012 01:32:28 +0000
Message-ID: <9E44E06DBBA23A489DED933DBC291A850FD6FF97@SHSMSX102.ccr.corp.intel.com>
References: <1351872943.4332.37.camel@chenjun-workstation>
	<20121102112945.535bfea7@pyramind.ukuu.org.uk>
	<9E44E06DBBA23A489DED933DBC291A850FD6FE1F@SHSMSX102.ccr.corp.intel.com>
 <20121105114329.0f60b484@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42036 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372Ab2KFBdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Nov 2012 20:33:45 -0500
In-Reply-To: <20121105114329.0f60b484@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Liu, Chuansheng" <chuansheng.liu@intel.com>, "Bi, Chao" <chao.bi@intel.com>

Hi, Alan,
    Thank you very much! 

Jun

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, November 05, 2012 7:43 PM
To: Chen, Jun D
Cc: alan@linux.intel.com; linux-serial@vger.kernel.org; Gorby, Russ; Liu, Chuansheng; Bi, Chao
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the modem status through sysfs.

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
> I want to submit one finished version, but these code need to call the 
> intel_scu_ipc_readv and intel_scu_ipc_writev function defined in the file <asm/intel_scu_ipc.h> But this module seem not to be maked. Now I add one macro to disable these functions. I will send the new patch to you and would you like to give more suggestion about this issue.

You probably need your Kconfig entry to have

	depends on X86_INTEL_MID && INTEL_SCU_IPC

so that it can only be compiled when the feature is present.

Alan
