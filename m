From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ patch 2/7] drivers/serial/jsm: new serial device driver
Date: Sun, 27 Feb 2005 19:25:11 -0500
Message-ID: <422264E7.1030602@pobox.com>
References: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64398 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261254AbVB1AZ3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Feb 2005 19:25:29 -0500
In-Reply-To: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Wen Xiong wrote:
> +#define TMPBUFLEN (1024)
> +
> +/*
> + * jsm_sniff - Dump data out to the "sniff" buffer if the
> + * proc sniff file is opened...
> + */
> +
> +void jsm_sniff_nowait_nolock(struct channel_t *ch, uchar *text, uchar *buf, int len)
> +{
> +	struct timeval tv;
> +	int n;
> +	int r;
> +	int nbuf;
> +	int i;
> +	int tmpbuflen;
> +	char tmpbuf[TMPBUFLEN];

Uses WAY too much stack space.

	Jeff


