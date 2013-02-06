From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 3/4] pps: Use lookup list to reduce ldisc coupling
Date: Wed, 06 Feb 2013 17:20:33 +0100
Message-ID: <511282D1.7030200@suse.cz>
References: <20130204010303.24971.qmail@science.horizon.com> <1360166116-30797-1-git-send-email-peter@hurleysoftware.com> <1360166116-30797-4-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:38501 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670Ab3BFQUj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 11:20:39 -0500
In-Reply-To: <1360166116-30797-4-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: George Spelvin <linux@horizon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rodolfo Giometti <giometti@enneenne.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/06/2013 04:55 PM, Peter Hurley wrote:
> --- a/drivers/pps/clients/pps-ldisc.c
> +++ b/drivers/pps/clients/pps-ldisc.c
> @@ -25,17 +25,47 @@
...
> +struct pps_data {
> +	struct pps_device *pps;
> +	struct tty_struct *tty;
> +	struct list_head link;
> +};
> +
> +DEFINE_SPINLOCK(pps_lock);
> +static LIST_HEAD(pps_list);

All 4 look fine, nice cleanup. Except the lock above should be static too.

thanks,
-- 
js
suse labs
