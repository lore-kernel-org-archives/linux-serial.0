From: Ilya Zykov <ilya@ilyx.ru>
Subject: Re: [PATCH] tty: Fix unreasonable write toward closed pty.
Date: Wed, 19 Dec 2012 23:38:28 +0400
Message-ID: <50D217B4.6000104@ilyx.ru>
References: <50D20E87.9060403@ilyx.ru> <20121219191030.4ee20a1c@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:60482 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614Ab2LSTib (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Dec 2012 14:38:31 -0500
In-Reply-To: <20121219191030.4ee20a1c@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Sasha Levin <levinsasha928@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 19.12.2012 23:10, Alan Cox wrote:
>> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
>> index a82b399..1ce1362 100644
>> --- a/drivers/tty/pty.c
>> +++ b/drivers/tty/pty.c
>> @@ -116,6 +116,8 @@ static int pty_space(struct tty_struct *to)
>>  
>>  static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
>>  {
>> +	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
>> +		return -EIO;
> 
> The flag can change between the test and ny further code being executed ?
> 
> Alan
> 

Yes, if I understand you correctly, but this is no matter here,
because ldisc's layer will wait, flush this data later.
Here, only beginning stage of tty_close.
This is safe later stage from unnecessary data.

Ilya

