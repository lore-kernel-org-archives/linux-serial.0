From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: about CONFIG_CMDLINE
Date: Thu, 13 Aug 2009 12:02:26 -0700
Message-ID: <4A846342.8070200@oracle.com>
References: <241b8f7b0908112320u44519e7fnfbc4fa96667cdb20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:21315 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbZHMTBu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Aug 2009 15:01:50 -0400
In-Reply-To: <241b8f7b0908112320u44519e7fnfbc4fa96667cdb20@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prabhu Chawandi <prabhu.chavandi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Prabhu Chawandi wrote:
> Hi,
> 
>   In kernel_hardening activity, I am setting CONFIG_CMDLINE, to
> 
> CONFIG_CMDLINE is nit set.
> 
> But while building, it is prompting to select its state(y/n).
> 
> I want to disable this prompting, how can I do it ?
> 
> Any idea, please share ...

Proably posting your troublesome .config file would help,
along with your kernel version info... but I can see that
CONFIG_CMDLINE depends on CONFIG_CMDLINE_BOOL.
Do you also unset CONFIG_CMDLINE_BOOL ?

~Randy

