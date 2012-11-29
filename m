From: Ilya Zykov <ilya@ilyx.ru>
Subject: Re: [PATCH] tty: Correct tty buffer flushing.
Date: Thu, 29 Nov 2012 18:13:42 +0400
Message-ID: <50B76D96.20809@ilyx.ru>
References: <50B55A93.4090900@ilyx.ru> <50B6A652.9000107@ilyx.ru> <20121129135418.4237e7f8@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121129135418.4237e7f8@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Xiaobing Tu <xiaobing.tu@intel.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Alek Du <alek.du@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

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
Sorry, In you reply not all patch.
Main idea here -  we never flash last (struct tty_buffer) in the active buffer.
Only data for ldisc. (tty->buf.head->read = tty->buf.head->commit).
At that moment driver can collect(write) data in buffer without conflict.


--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -114,11 +114,14 @@ static void __tty_buffer_flush(struct tty_struct *tty)
 {
 	struct tty_buffer *thead;
 
-	while ((thead = tty->buf.head) != NULL) {
-		tty->buf.head = thead->next;
-		tty_buffer_free(tty, thead);
+	if (tty->buf.head == NULL)
+		return;
+	while ((thead = tty->buf.head->next) != NULL) {
+		tty_buffer_free(tty, tty->buf.head);
+		tty->buf.head = thead;
 	}
-	tty->buf.tail = NULL;
+	WARN_ON(tty->buf.head != tty->buf.tail);
+	tty->buf.head->read = tty->buf.head->commit;
 }
 
 /**
