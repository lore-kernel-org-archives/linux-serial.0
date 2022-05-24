Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90929C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 09:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiEXJLr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiEXJLq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 05:11:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30101EAEA
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653383504; x=1684919504;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Xuha6AedGwfVmpfLM6Pcd6YzeRzMKwbZ3+ru2QXLR44=;
  b=dl9RmFsWB8/DnfmcchcgLCeOIr45dLx4xaNkCxnyOphzC2B2+zAlWvdc
   qaSOyltou93hM2Tt4Ey9R4zi4zeiEVC1MPyUNwVhMc4S9V8dVr3J1eelc
   tNzNKFqkJzccZDM5ca9dJWsvjZZiv8kjdWSu2QHY7bHahQ1gkVsU1+9Br
   xxJO7kvXROaB7tIzBrIjqIko7ENTpylyah4+SD69FXfiAOW+Lh6HyL7vQ
   scbRXgkeYePF3M9WT9lDMrTiSKEJkD+mROaN9Y0PfMiQQp4FT8ZbbOf/7
   mi1KlbgUVcJDLVCYq1W4A4UCw8XKRyinTsDedyFPRCb4nO2ZqSFzeYgsf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="298794959"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="298794959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 02:11:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="601126176"
Received: from jzawadzk-mobl2.amr.corp.intel.com ([10.251.212.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 02:11:42 -0700
Date:   Tue, 24 May 2022 12:11:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
In-Reply-To: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
Message-ID: <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 24 May 2022, cael wrote:

> We have met a hang on pty device, the reader was blocking at
>  epoll on master side, the writer was sleeping at wait_woken inside
>  n_tty_write on slave side ,and the write buffer on tty_port was full, we

Space after comma. It would be also useful to tone down usage of "we" in 
the changelog.

>  found that the reader and writer would never be woken again and block
>  forever.
> 
> We thought the problem was caused as a race between reader and
> kworker as follows:
> n_tty_read(reader)| n_tty_receive_buf_common(kworker)
>                   |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
>                   |room <= 0
> copy_from_read_buf|
> n_tty_kick_worker |
>                   |ldata->no_room = true
>
> After writing to slave device, writer wakes up kworker to flush
> data on tty_port to reader, and the kworker finds that reader
> has no room to store data so room <= 0 is met. At this moment,
> reader consumes all the data on reader buffer and call
> n_tty_kick_worker to check ldata->no_room and finds that there
> is no need to call tty_buffer_restart_work to flush data to reader
> and reader quits reading. Then kworker sets ldata->no_room=true
> and quits too.
> 
> If write buffer is not full, writer will wake kworker to flush data
> again after following writes, but if writer buffer is full and writer
> goes to sleep, kworker will never be woken again and tty device is
> blocked.
> 
> We think this problem can be solved with a check for read buffer
> inside function n_tty_receive_buf_common, if read buffer is empty and
> ldata->no_room is true, this means that kworker has more data to flush
> to read buffer, so a call to n_tty_kick_worker is necessary.
> 
> Signed-off-by: cael <juanfengpy@gmail.com>
> ---
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..36c7bc033c78 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> const unsigned char *cp,
>         } else
>                 n_tty_check_throttle(tty);
> 
> +       if (!chars_in_buffer(tty))
> +               n_tty_kick_worker(tty);
> +

chars_in_buffer() accesses ldata->read_tail in producer context so this 
probably just moves the race there?


-- 
 i.

