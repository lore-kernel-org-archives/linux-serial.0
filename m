From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq@rere.qmqm.pl>
Subject: Re: [PATCH 2/2] n_gsm: add a documentation
Date: Tue, 8 Mar 2011 13:34:55 +0100
Message-ID: <20110308123455.GA7913@rere.qmqm.pl>
References: <1299543872-14580-1-git-send-email-eric@eukrea.com> <1299543872-14580-2-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:42840 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab1CHMe5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Mar 2011 07:34:57 -0500
Content-Disposition: inline
In-Reply-To: <1299543872-14580-2-git-send-email-eric@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Eric =?iso-8859-2?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Tue, Mar 08, 2011 at 01:24:32AM +0100, Eric B=E9nard wrote:
> * this documentation gives some details on how to get the n_gsm
> line discipline to work with modems supporting 07.10 basic option.
[...]
> --- /dev/null
> +++ b/Documentation/serial/n_gsm.txt
[...]
> +How to use it
> +-------------
> +1- initialize the modem in 0710 mux mode (usually AT+CMUX=3D command=
) through
> +its serial port. Depending on the modem used, you can pass more or l=
ess
> +parameters to this command,
> +2- switch the serial line to using the n_gsm line discipline by usin=
g
> +TIOCSETD ioctl,
> +3- configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
> +
> +Major parts of the initialization program :
[...]
> +	/* and wait for ever to keep the line discipline enabled */
> +	while(1) sleep(1);

People will probably copy this without much thinking. It's better to us=
e
pause() in the loop to let the process sink to swap completely instead
of waking it every second to do nothing.

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
