From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/4] pps: Use lookup list to reduce ldisc coupling
Date: Wed, 06 Feb 2013 11:41:03 -0500
Message-ID: <1360168863.3298.60.camel@thor.lan>
References: <20130204010303.24971.qmail@science.horizon.com>
	 <1360166116-30797-1-git-send-email-peter@hurleysoftware.com>
	 <1360166116-30797-4-git-send-email-peter@hurleysoftware.com>
	 <511282D1.7030200@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:54675 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756889Ab3BFQlM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 11:41:12 -0500
In-Reply-To: <511282D1.7030200@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: George Spelvin <linux@horizon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rodolfo Giometti <giometti@enneenne.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2013-02-06 at 17:20 +0100, Jiri Slaby wrote:
> On 02/06/2013 04:55 PM, Peter Hurley wrote:
> > --- a/drivers/pps/clients/pps-ldisc.c
> > +++ b/drivers/pps/clients/pps-ldisc.c
> > @@ -25,17 +25,47 @@
> ...
> > +struct pps_data {
> > +	struct pps_device *pps;
> > +	struct tty_struct *tty;
> > +	struct list_head link;
> > +};
> > +
> > +DEFINE_SPINLOCK(pps_lock);
> > +static LIST_HEAD(pps_list);
> 
> All 4 look fine, nice cleanup. Except the lock above should be static too.

Whoops. Thanks for catching that!  (rebasing error... :)


