From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCHv2] tty: Added a CONFIG_TTY option to allow removal of
 TTY
Date: Mon, 03 Sep 2012 23:15:58 +0200
Message-ID: <50451E0E.1050605@suse.cz>
References: <1346633072-29361-1-git-send-email-jmillenbach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64347 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2ICVQD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Sep 2012 17:16:03 -0400
In-Reply-To: <1346633072-29361-1-git-send-email-jmillenbach@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joe Millenbach <jmillenbach@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, team-fjord@googlegroups.com, Josh Triplett <josh@joshtriplett.org>, "jirisl >> Jiri Slaby" <jirislaby@gmail.com>

On 09/03/2012 02:44 AM, Joe Millenbach wrote:
> The option allows you to remove TTY and compile without errors. This
> saves space on systems that won't support TTY interfaces anyway.
> bloat-o-meter output is below.
...
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -1,3 +1,14 @@
> +config TTY
> +	bool "Enable TTY" if EXPERT
> +	default y
> +	---help---
> +	  Allows you to remove TTY support which can save space, and
> +	  blocks features that require TTY from inclusion in the kernel.
> +	  TTY is required for any text terminals or serial port
> +	  communication. Most users should leave this enabled.
> +
> +if TTY
> +
>  config VT
>  	bool "Virtual terminal" if EXPERT
>  	depends on !S390 && !UML
> @@ -355,6 +366,8 @@ config TRACE_SINK
>  	  If you select this option, you need to select
>  	  "Trace data router for MIPI P1149.7 cJTAG standard".
>  
> +endif # TTY
> +
>  config PPC_EPAPR_HV_BYTECHAN
>  	tristate "ePAPR hypervisor byte channel driver"
>  	depends on PPC

Hmm, I wonder why do not you include EHV in the depends-on-tty list?

thanks,
-- 
js
suse labs
