From: Ilya Zykov <ilya@ilyx.ru>
Subject: Re: [PATCH] tty: Correct tty buffer flushing.
Date: Thu, 29 Nov 2012 18:03:49 +0400
Message-ID: <50B76B45.1080809@ilyx.ru>
References: <50B55A93.4090900@ilyx.ru> <50B6A652.9000107@ilyx.ru> <20121129135418.4237e7f8@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:51320 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754211Ab2K2OEF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Nov 2012 09:04:05 -0500
In-Reply-To: <20121129135418.4237e7f8@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Xiaobing Tu <xiaobing.tu@intel.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Alek Du <alek.du@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 29.11.2012 17:54, Alan Cox wrote:
>> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>> index 6c9b7cd..4f02f9c 100644
>> --- a/drivers/tty/tty_buffer.c
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -114,11 +114,14 @@ static void __tty_buffer_flush(struct tty_struct *tty)
>>  {
>>  	struct tty_buffer *thead;
>>  
>> -	while ((thead = tty->buf.head) != NULL) {
>> -		tty->buf.head = thead->next;
>> -		tty_buffer_free(tty, thead);
>> +	if (tty->buf.head == NULL)
>> +		return;
>> +	while ((thead = tty->buf.head->next) != NULL) {
>> +		tty_buffer_free(tty, tty->buf.head);
>> +		tty->buf.head = thead;
> 
> This part of the change seems to have no effect at all. There are no
> locks held so there is nothing guaranteeing how the other processors
> views of the order of operations will be affected.
> 
> Alan
> 
/**
 *	__tty_buffer_flush		-	flush full tty buffers
 *	@tty: tty to flush
 *
 *	flush all the buffers containing receive data. Caller must
 *	hold the buffer lock and must have ensured no parallel flush to
 *	ldisc is running.
 *
 *	Locking: Caller must hold tty->buf.lock
 */

Please, don't ignore my patch.
Please, Look at it one more time thoroughly.
Before REVERT [PATCH] tty: hold lock across tty buffer finding and buffer filling.
Thank you.


