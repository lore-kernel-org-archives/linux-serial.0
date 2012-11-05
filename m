From: "Chen, Jun D" <jun.d.chen@intel.com>
Subject: RE: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Mon, 5 Nov 2012 08:26:08 +0000
Message-ID: <9E44E06DBBA23A489DED933DBC291A850FD6FE1F@SHSMSX102.ccr.corp.intel.com>
References: <1351872943.4332.37.camel@chenjun-workstation>
 <20121102112945.535bfea7@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52902 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2KEI0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Nov 2012 03:26:13 -0500
In-Reply-To: <20121102112945.535bfea7@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "Liu, Chuansheng" <chuansheng.liu@intel.com>, "Bi, Chao" <chao.bi@intel.com>

Hi,Alan
    Thank your reply and advice. 
> +	if (reset_request == IFX_COLD_RESET_REQ) {
> +		/*  Need to add these action for modem cold reset:
> +		* - Set the RESET_BB_N to low (better SIM protection)
> +		* - Set the EXT1P35VREN field to low  during 20ms (V1P35CNT_W  register)
> +		* - set the EXT1P35VREN field to high during 10ms (V1P35CNT_W  register)
> +		*/
I want to submit one finished version, but these code need to call the intel_scu_ipc_readv and intel_scu_ipc_writev function defined in the file <asm/intel_scu_ipc.h>
But this module seem not to be maked. Now I add one macro to disable these functions. I will send the new patch to you and would you like to give more suggestion about this issue.

About the reset_ongoing variable and hangup_reasons variable, I have modify these codes, use mdm_reset_state variable(old ) and hangup_reasons 
variable( add ) in the the device structure to realize the codes. 
The variable mdm_reset_state used to tell the user space the status about modem reset status and void to run even twice at once.
The variable hangup_reasons used to give one interface to user space to know and clear the reason of modem reset, which don't need to locked.
I've update the patch as your suggestion, please check another PATCH mail.

Jun

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Friday, November 02, 2012 7:30 PM
To: Chen, Jun D
Cc: alan@linux.intel.com; linux-serial@vger.kernel.org; Gorby, Russ; Liu, Chuansheng; Bi, Chao
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the modem status through sysfs.

> +	if (reset_request == IFX_COLD_RESET_REQ) {
> +		/*  Need to add these action for modem cold reset:
> +		* - Set the RESET_BB_N to low (better SIM protection)
> +		* - Set the EXT1P35VREN field to low  during 20ms (V1P35CNT_W  register)
> +		* - set the EXT1P35VREN field to high during 10ms (V1P35CNT_W  register)
> +		*/

You seem to have submitted an unfinished version ?

Also can you explain the locking on your new reset_ongoing variable and hangup_reasons variable ? What stops the sysfs code being run in parallel with the other bits or even twice at once.

Looking at it I get the impression that

a) the variable should be in the device structure not a static global
b) it is write only which seems pointless
c) you probably want a mutex around the actual reset processes so that reset is single threaded in each case.
d) that mutex probably belongs in the device structure
 

The hangup reasons in this patch also appears to be write only ?

Alan
