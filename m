From: whitnl73@juno.com
Subject: Re: RS485 communicatio
Date: Fri, 14 Mar 2003 19:36:37 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030314.215039.8.0.whitnl73@juno.com>
References: <20030313.222518.8.0.whitnl73@juno.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030313.222518.8.0.whitnl73@juno.com>
List-Id: linux-serial@vger.kernel.org
To: whitnl73@juno.com
Cc: linuxppp@indiainfo.com, linux-serial@vger.kernel.org

On Thu, 13 Mar 2003 whitnl73@juno.com wrote:

>
> AFAIK there is no usable protocol for multidtop serial lines.  Ring ten
> times for system a, 9 got system b...
>
> | ii) If there is no direct support how do i go ahead. Is there any other
> | layer 2 protocol allows me to acheive TCP/IP communicattion over RS485
> | which is my ultimatum.
>
> Use a separate serial line between each pair of nodes, or make one a
> sort of hub and run a line from it to each other node?
> |
> | I will be grateful if anybody of them could help me with my current
> | problem.
> |
> | Thanx in advance.
> |
> | Karthik
> |
> | --

Hmmm, what is this?

PPP multilink support (EXPERIMENTAL)
CONFIG_PPP_MULTILINK
  PPP multilink is a protocol (defined in RFC 1990) which allows you
  to combine several (logical or physical) lines into one logical PPP
  connection, so that you can utilize your full bandwidth.

  This has to be supported at the other end as well and you need a
  version of the pppd daemon which understands the multilink protocol.

  If unsure, say N.

Configure.help line 7235/19377 37%
>
Seem to be some things in man pppd about multilink, too.

> Lawson
> --
> ---oops---
>
>
>
> ________________________________________________________________
> Sign Up for Juno Platinum Internet Access Today
> Only $9.95 per month!
> Visit www.juno.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
