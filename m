Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893544;
	b=dqzOLzu73Iy0kf9/k702rp8I0tZrOZpbZrxQtww76By45z2gFFMwjEpc2nGMxq/RuM+P
	 pw6EnzkB66F+mVQBTmfEjQUQkPiOUL6Jr1L6V7hxLBmk3jk+JaGE32jtIKUJgWsgCKJLg
	 HOgtkEQEXwcUzpL0qpv4cgfbnVD5TO9s3b5uayKNClp8/M16QyQjDybKBDNwBs3LiRph8
	 B040eYJVD9tDFD3uuIgsk3erG/xOmvbbUT2Ea9WZpHBO6IcPWuEKz397qfj3oEGP+Uzur
	 z0rXrm73bxOSV20kDq4JN35sDdmMNTpfIml26fcBlNLHH0SBUAXt+lJSJItBOxokbHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893544;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZazM5zRIs19FuXg6+9N/oRV7niuVghWSrIJJGlMBDDs=;
	b=3oTc5UPWvmL5HIzCVg4AIEWAhorV8jenwgBBCWV0qjrvrnanDtXSFE9kKfH1GAMgRhsU
	 3xXSNQlF13mAXEWgAFeZTi+NMsKMQy/oynBTN6KJogsd/4L6JRJ2VzmUuGjJEy5GYsPqS
	 Evw9/ltQy9MdMcUajp0ycvf7oEFF54TEPr86Ov5sDJT2La4wE/B6fYtOVdodkxwZVf264
	 COm6xOjgbLZ6pJP5WBwtDD6QYwwHyv02xhPKDH/JDg/R1EBWpjglYP2bSycWmd9nA2Jzl
	 AKytckNEHasnf/56rTh/SXlqlSLgxW8znk2okRDWp0pZBLwvAH4dXB9PpFxXJtQd5Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpha.franken.de;
	spf=pass smtp.mailfrom=alpha.franken.de;
	arc=none smtp.remote-ip=193.175.24.41
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A8606A33A;
	Thu,  5 Nov 2026 15:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8A8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xOzeg-00071E-00; Thu, 05 Nov 2026 16:45:34 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B10A4C0520; Thu,  5 Nov 2026 16:23:30 +0100 (CET)
Date: Thu, 5 Nov 2026 16:23:30 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] MIPS: SGI-IP27: print the NMI dump on an nbcon console
Message-ID: <auyfcm7ml2fUmfUG@alpha.franken.de>
References: <20261001191938.3256-1-kaloz@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001191938.3256-1-kaloz@kernel.org>

On Thu, Oct 01, 2026 at 09:19:38PM +0200, Imre Kaloz wrote:
> Since the 8250 console became nbcon, printk() in nmi_dump() only queues
> records for a printer thread that never runs, as no CPU leaves the NMI
> handler. Print from an emergency section and flush pending records
> before the hub reset.
> 
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
> v2: flush pending records before the hub reset (John Ogness)
> v1: https://lore.kernel.org/all/20261001155013.1694-1-kaloz@kernel.org/
> 
> This conflicts by context with patch 14/38 of the IP35 series,
> https://lore.kernel.org/all/76f2a9c32eba23de36817f0a186def01e009e1c7.1790857966.git.kaloz@kernel.org/
> which rewrites the reset write. Whichever lands second places the
> printk_trigger_flush() call above the system_is_ip35 branch.
> 
>  arch/mips/sgi-ip27/ip27-nmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
> index fc2816398d0c..c502982621e6 100644
> --- a/arch/mips/sgi-ip27/ip27-nmi.c
> +++ b/arch/mips/sgi-ip27/ip27-nmi.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/console.h>
>  #include <linux/kernel.h>
>  #include <linux/mmzone.h>
>  #include <linux/nodemask.h>
> @@ -183,6 +184,12 @@ static void nmi_dump(void)
>  	 */
>  	arch_spin_lock(&nmi_lock);
>  
> +	/*
> +	 * No CPU leaves the NMI handler before the hub reset below, so an
> +	 * nbcon console's printer thread would never print the dump.
> +	 */
> +	nbcon_cpu_emergency_enter();
> +
>  #ifdef REAL_NMI_SIGNAL
>  	/*
>  	 * Wait up to 15 seconds for the other cpus to respond to the NMI.
> @@ -227,5 +234,6 @@ static void nmi_dump(void)
>  	 * Save the nmi cpu registers for all cpu in the eframe format.
>  	 */
>  	nmi_eframes_save();
> +	printk_trigger_flush();
>  	LOCAL_HUB_S(NI_PORT_RESET, NPR_PORTRESET | NPR_LOCALRESET);
>  }
> -- 
> 2.47.3

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
