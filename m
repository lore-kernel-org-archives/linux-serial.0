Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93338C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4067E23975
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbhAUJlN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:41:13 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:45765 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbhAUJkp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 04:40:45 -0500
Received: by mail-ej1-f49.google.com with SMTP id ke15so1632034ejc.12;
        Thu, 21 Jan 2021 01:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2K+N67nLg17oc17iRiM37F6/UhrQxKklC0Dn+MIhww=;
        b=EI1D5MqXZTsSyOyEI4hHFo7wuz6V9bYdNrm5heNTjcbxv14C9mIUh7cJMSGkMyYeA8
         cmA/ZEwWcNBiAknnzSnc1IG68Qxkq+i5ciXDLs+93Gs+Wf2mLfnVXKge9WcVoCEKJbc/
         /sTJe1Xk0nGY7/XkMkyxzujtHk+CvpHnJmwZtdVfo64OwcawRDDP9Joidzf+d/yWIhRL
         aUjHoEp7lQ3xhcT7ngAYaXwRU2hyv0EBLmuC86r+hOHNN94Pod8gaLSgVOmWzPfZPDZl
         iBUj185stygrDj4EhiFPOJHV5LIq0sjhA4qtkCOzHLv6xUIGoPJlEM0bNd6lZTV4hq/k
         lyPw==
X-Gm-Message-State: AOAM5335rpNwOWBjFDs8vjHLgioSDeQ3fPuNVvOo+1R0XGNJgnWyftSX
        py7WJjzONL71TOy6DOgL4CA=
X-Google-Smtp-Source: ABdhPJwbCFtlCf9hzBp4r+jA6JL2dMQZqLBvsLJjb3fooVUyL0VJYmUA7PYB6mHKID23yB9genpyOQ==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr8946657ejc.529.1611222000183;
        Thu, 21 Jan 2021 01:40:00 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i6sm1972011ejd.110.2021.01.21.01.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 01:39:59 -0800 (PST)
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ohw.giles@gmail.com, r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
Date:   Thu, 21 Jan 2021 10:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 01. 21, 10:00, Greg Kroah-Hartman wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> This makes the tty layer use the .write_iter() function instead of the
> traditional .write() functionality.
> 
> That allows writev(), but more importantly also makes it possible to
> enable .splice_write() for ttys, reinstating the "splice to tty"
> functionality that was lost in commit 36e2c7421f02 ("fs: don't allow
> splice read/write without explicit ops").
> 
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> Reported-by: Oliver Giles <ohw.giles@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>   drivers/tty/tty_io.c | 48 ++++++++++++++++++++++++--------------------
>   1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 56ade99ef99f..338bc4ef5549 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -143,9 +143,8 @@ LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
>   DEFINE_MUTEX(tty_mutex);
>   
>   static ssize_t tty_read(struct file *, char __user *, size_t, loff_t *);
> -static ssize_t tty_write(struct file *, const char __user *, size_t, loff_t *);
> -ssize_t redirected_tty_write(struct file *, const char __user *,
> -							size_t, loff_t *);
> +static ssize_t tty_write(struct kiocb *, struct iov_iter *);
> +ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
>   static __poll_t tty_poll(struct file *, poll_table *);
>   static int tty_open(struct inode *, struct file *);
>   long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> @@ -478,7 +477,8 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
>   static const struct file_operations tty_fops = {
>   	.llseek		= no_llseek,
>   	.read		= tty_read,
> -	.write		= tty_write,
> +	.write_iter	= tty_write,
> +	.splice_write	= iter_file_splice_write,
>   	.poll		= tty_poll,
>   	.unlocked_ioctl	= tty_ioctl,
>   	.compat_ioctl	= tty_compat_ioctl,
> @@ -491,7 +491,8 @@ static const struct file_operations tty_fops = {
>   static const struct file_operations console_fops = {
>   	.llseek		= no_llseek,
>   	.read		= tty_read,
> -	.write		= redirected_tty_write,
> +	.write_iter	= redirected_tty_write,
> +	.splice_write	= iter_file_splice_write,
>   	.poll		= tty_poll,
>   	.unlocked_ioctl	= tty_ioctl,
>   	.compat_ioctl	= tty_compat_ioctl,
> @@ -607,9 +608,9 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
>   	/* This breaks for file handles being sent over AF_UNIX sockets ? */
>   	list_for_each_entry(priv, &tty->tty_files, list) {
>   		filp = priv->file;
> -		if (filp->f_op->write == redirected_tty_write)
> +		if (filp->f_op->write_iter == redirected_tty_write)
>   			cons_filp = filp;
> -		if (filp->f_op->write != tty_write)
> +		if (filp->f_op->write_iter != tty_write)

This now relies on implicit value of hung_up_tty_fops.write_iter (i.e. 
NULL), okay.

>   			continue;
>   		closecount++;
>   		__tty_fasync(-1, filp, 0);	/* can't block */
 > 		filp->f_op = &hung_up_tty_fops;

Isn't this racy with VFS layer in vfs_write:
         if (file->f_op->write)
                 ret = file->f_op->write(file, buf, count, pos);
         else if (file->f_op->write_iter)
                 ret = new_sync_write(file, buf, count, pos);

? hung_up_tty_fops do not set iter_write and tty_fops do not set write. 
When we switch from one to the other here, right after the 'if', but 
before the call, what happens? Likely nothing for the ->write case 
immediately as compilers cache the value, but for ->write_iter, I'm not 
sure. Anyway, this looks broken to me. (Read on.)

> @@ -956,14 +957,20 @@ static inline ssize_t do_tty_write(
>   		size_t size = count;
>   		if (size > chunk)
>   			size = chunk;
> +
>   		ret = -EFAULT;
> -		if (copy_from_user(tty->write_buf, buf, size))
> +		if (copy_from_iter(tty->write_buf, size, from) != size)
>   			break;
> +
>   		ret = write(tty, file, tty->write_buf, size);
>   		if (ret <= 0)
>   			break;
> +
> +		/* FIXME! Have Al check this! */
> +		if (ret != size)
> +			iov_iter_revert(from, size-ret);
> +
>   		written += ret;
> -		buf += ret;
>   		count -= ret;
>   		if (!count)
>   			break;
> @@ -1023,9 +1030,9 @@ void tty_write_message(struct tty_struct *tty, char *msg)
>    *	write method will not be invoked in parallel for each device.
>    */
>   
> -static ssize_t tty_write(struct file *file, const char __user *buf,
> -						size_t count, loff_t *ppos)
> +static ssize_t tty_write(struct kiocb *iocb, struct iov_iter *from)
>   {
> +	struct file *file = iocb->ki_filp;
>   	struct tty_struct *tty = file_tty(file);
>    	struct tty_ldisc *ld;
>   	ssize_t ret;
> @@ -1038,18 +1045,15 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
>   	if (tty->ops->write_room == NULL)
>   		tty_err(tty, "missing write_room method\n");
>   	ld = tty_ldisc_ref_wait(tty);
> -	if (!ld)
> -		return hung_up_tty_write(file, buf, count, ppos);
> -	if (!ld->ops->write)
> +	if (!ld || !ld->ops->write)
>   		ret = -EIO;
>   	else
> -		ret = do_tty_write(ld->ops->write, tty, file, buf, count);
> +		ret = do_tty_write(ld->ops->write, tty, file, from);
>   	tty_ldisc_deref(ld);

Ok, here belongs my earlier note: "if ld == NULL => crash here." That is 
if hangup happens during the ldisc wait, the kernel will crash in 
tty_ldisc_deref.

Is there a reason not to convert hung_up_tty_fops too and leave the 
return hung_up_tty_write here intact? This would also solve the comments 
above.

>   	return ret;
>   }
>   
> -ssize_t redirected_tty_write(struct file *file, const char __user *buf,
> -						size_t count, loff_t *ppos)
> +ssize_t redirected_tty_write(struct kiocb *iocb, struct iov_iter *iter)
>   {
>   	struct file *p = NULL;
>   

thanks,
-- 
js
