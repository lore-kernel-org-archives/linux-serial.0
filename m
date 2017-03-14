From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/3] printk: fix double printing with earlycon
Date: Tue, 14 Mar 2017 16:17:59 +0000
Message-ID: <f6d929e6-0acc-3654-7d61-e0f1c67642f5@arm.com>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>
List-Id: linux-serial@vger.kernel.org

Hi Aleksey,

(Sorry for the delayed response, was on vacation)

On 02/03/17 13:11, Aleksey Makarov wrote:
> If a console was specified by ACPI SPCR table _and_ command line parameters like
> "console=ttyAMA0" _and_ "earlycon" were specified, then log messages
> appear twice.
> 
> This issue was addressed in the patch [1] but the approach was wrong and
> a revert [2] was suggested.
> 
> First two patches "printk: fix name/type/scope of preferred_console var" and
> "printk: rename selected_console -> preferred_console" were sent sent some
> time ago as one patch "printk: fix name and type of some variables" [3].
> They fix name/type/scope of some variables without changing the logic.
> 
> The real fix is in the second patch.  The root cause is that the code traverses
> the list of specified consoles (the `console_cmdline` array) and stops at the
> first match.  But it may happen that the same console is referred by
> the elements of this array twice:
> 
> 	pl011,mmio,0x87e024000000,115200 -- from SPCR
> 	ttyAMA0 -- from command line
> 
> but in this case `preferred_console` points to the second entry and
> the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
> 
> To fix that, match the console against the `console_cmdline` entry
> pointed by `preferred_console` instead of the first match.
> 
> v2:
> - split the patch that renames `selected_console` and `preferred_console`
>   into two patches (Steven Rostedt)
> - add a comment explaining why we need a separate match to check for
>   preferred_console (Steven Rostedt)
> - v1 of this patchset changed the logic of console initialization a bit.
>   That could lead to bugs/incompatibilities.  Use the exactly the same
>   logic as in the original code.
> 

Tested the series(v3 of patch 3) and works as expected. Thanks for the
proper fix.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
