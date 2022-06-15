Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DEC43334
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 11:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbiFOL3d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347864AbiFOL3b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 07:29:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B452E42
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655292570; x=1686828570;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1HschoPjd2zP8YgkMKNgIBoXbflqr6F1MDHBt9P9JEw=;
  b=ByNQRIHUcJ97pIi4/LuJTjVhz2WEobb+sbYDFSLB/fyyanT12nXPKC8r
   /yHF8fPyNgoUwLGw/aKQ1At2WhtbGyzUaIPAV1QMSP+OCvUBd2e1lhVBZ
   ZkxM/MoObbEs1eraQbMHATxx6/EHJOcYIvLsiraqHSE1kzMSRYIuuPrdv
   jGit1YF2ojFpP36Gr4Yr0vQ2paObzGQMx4RxISk3/F8WucOGQJLGIkJdw
   dZj9l7E3Wxzmu5TNmoQG1Hc52iwptewIBgLdQtYdJHl7FzCFrGYGAjhMK
   q9X0UwGwFAh3YB9MPeQ1C/Npc66S0DeASS2KNt49eY/qeGQ1WY6CEAJvL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278975826"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="278975826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:29:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="640944514"
Received: from mgrymel-mobl1.ger.corp.intel.com ([10.249.41.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:29:28 -0700
Date:   Wed, 15 Jun 2022 14:29:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, benbjiang@tencent.com,
        robinlai@tencent.com, linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5] tty: fix hang on tty device with no_room set
In-Reply-To: <1655291821-19676-1-git-send-email-juanfengpy@gmail.com>
Message-ID: <4354aab5-e01d-c631-9479-cc7c9246d68@linux.intel.com>
References: <YqmmdRynrDSzNL0W@kroah.com> <1655291821-19676-1-git-send-email-juanfengpy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-915404693-1655292570=:1642"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-915404693-1655292570=:1642
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 15 Jun 2022, cael wrote:

> From: caelli <juanfengpy@gmail.com>
> 
> We have met a hang on pty device, the reader was blocking
> at epoll on master side, the writer was sleeping at wait_woken
> inside n_tty_write on slave side, and the write buffer on
> tty_port was full, we found that the reader and writer would
> never be woken again and blocked forever.
> 
> The problem was caused by a race between reader and kworker:
> n_tty_read(reader):  n_tty_receive_buf_common(kworker):
>                     |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
>                     |room <= 0
> copy_from_read_buf()|
> n_tty_kick_worker() |
>                     |ldata->no_room = true
> 
> After writing to slave device, writer wakes up kworker to flush
> data on tty_port to reader, and the kworker finds that reader
> has no room to store data so room <= 0 is met. At this moment,
> reader consumes all the data on reader buffer and calls
> n_tty_kick_worker to check ldata->no_room which is false and
> reader quits reading. Then kworker sets ldata->no_room=true
> and quits too.
> 
> If write buffer is not full, writer will wake kworker to flush data
> again after following writes, but if write buffer is full and writer
> goes to sleep, kworker will never be woken again and tty device is
> blocked.
> 
> This problem can be solved with a check for read buffer size inside
> n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> is true, a call to n_tty_kick_worker is necessary to keep flushing
> data to reader.
> 
> Signed-off-by: caelli <juanfengpy@gmail.com>
> ---
> Patch changelogs between v1 and v2:
> 	-add barrier inside n_tty_read and n_tty_receive_buf_common;
> 	-comment why barrier is needed;
> 	-access to ldata->no_room is changed with READ_ONCE and WRITE_ONCE;
> Patch changelogs between v2 and v3:
> 	-in function n_tty_receive_buf_common, add unlikely to check
> 	 ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
> 	 is removed here to get locality;
> 	-change comment for barrier to show the race condition to make
> 	 comment easier to understand;
> Patch changelogs between v3 and v4:
> 	-change subject from 'tty: fix a possible hang on tty device' to
> 	 'tty: fix hang on tty device with no_room set' to make subject 
> 	 more obvious;
> Patch changelogs between v4 and v5:
> 	-name is changed from cael to caelli, li is added as the family
> 	 name and caelli is the fullname.
> 
>  drivers/tty/n_tty.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..544f782b9a11 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
>  	struct n_tty_data *ldata = tty->disc_data;
>  
>  	/* Did the input worker stop? Restart it */
> -	if (unlikely(ldata->no_room)) {
> -		ldata->no_room = 0;
> +	if (unlikely(READ_ONCE(ldata->no_room))) {
> +		WRITE_ONCE(ldata->no_room, 0);
>  
>  		WARN_RATELIMIT(tty->port->itty == NULL,
>  				"scheduling with invalid itty\n");
> @@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>  			if (overflow && room < 0)
>  				ldata->read_head--;
>  			room = overflow;
> -			ldata->no_room = flow && !room;
> +			WRITE_ONCE(ldata->no_room, flow && !room);
>  		} else
>  			overflow = 0;
>  
> @@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>  	} else
>  		n_tty_check_throttle(tty);
>  
> +	if (unlikely(ldata->no_room)) {
> +		/*
> +		 * Barrier here is to ensure to read the latest read_tail in
> +		 * chars_in_buffer() and to make sure that read_tail is not loaded
> +		 * before ldata->no_room is set, otherwise, following race may occur:
> +		 * n_tty_receive_buf_common() |n_tty_read()
> +		 * chars_in_buffer() > 0      |
> +		 *                            |copy_from_read_buf()->chars_in_buffer()==0
> +		 *                            |if (ldata->no_room)
> +		 * ldata->no_room = 1         |
> +		 * Then both kworker and reader will fail to kick n_tty_kick_worker(),
> +		 * smp_mb is paired with smp_mb() in n_tty_read().
> +		 */
> +		smp_mb();
> +		if (!chars_in_buffer(tty))
> +			n_tty_kick_worker(tty);
> +	}
> +
>  	up_read(&tty->termios_rwsem);
>  
>  	return rcvd;
> @@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
>  		if (time)
>  			timeout = time;
>  	}
> -	if (tail != ldata->read_tail)
> +	if (tail != ldata->read_tail) {
> +		/*
> +		 * Make sure no_room is not read before setting read_tail,
> +		 * otherwise, following race may occur:
> +		 * n_tty_read()		                |n_tty_receive_buf_common()
> +		 * if(ldata->no_room)->false            |
> +		 *			                |ldata->no_room = 1
> +		 *                                      |char_in_buffer() > 0
> +		 * ldata->read_tail = ldata->commit_head|
> +		 * Then copy_from_read_buf() in reader consumes all the data
> +		 * in read buffer, both reader and kworker will fail to kick
> +		 * tty_buffer_restart_work().
> +		 * smp_mb is paired with smp_mb() in n_tty_receive_buf_common().
> +		 */
> +		smp_mb();
>  		n_tty_kick_worker(tty);
> +	}
>  	up_read(&tty->termios_rwsem);
>  
>  	remove_wait_queue(&tty->read_wait, &wait);

I think the code looks fine. What I'm not entirely sure if there is 
supposed to be some other backup mechanism to handle this case.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Note to Cael: you don't need to resend the patch just to add my reviewed 
by, it would be picked by the tools automatically. But if you need to 
resend due to other reasons, please add it in that case.


-- 
 i.

--8323329-915404693-1655292570=:1642--
