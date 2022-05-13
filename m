Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C423C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 13 May 2022 08:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiEMIep (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 May 2022 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378346AbiEMIep (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 May 2022 04:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24652A7C3C
        for <linux-serial@vger.kernel.org>; Fri, 13 May 2022 01:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3DE620B2
        for <linux-serial@vger.kernel.org>; Fri, 13 May 2022 08:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC3DC34100;
        Fri, 13 May 2022 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652430883;
        bh=Qt/4PImgM3BmWxG5G5gsTmp+9QqKkzVOpe3OiR3TV04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bT95QtbQ2JbYgojHNuJzZPs4MF4GzwXAOHs1P0I2yPfW62j4DvAbuFjYHllF2yIlA
         nL0UM4rjqa0e3vXNs4vDkgYXiGC3L+dfn28SjVxbzuvTVYJTfo1/sSo2Puun2ajHdV
         15VNkQ18MN/GfAum1nGnbOd/nePgrKBVwk5+v/TEB1p7sKCCVimloTLZ57V4s3e2sn
         gV1SsnurXJv1s7Q/L8aefEyYsodSyRHL4FccHV4lhOV43NyJebh4gHZp9moSEAGCb4
         nxi4GmQ4jSe29Ld0WXMN9gjT37IZa+2s2uWyUtYfQfWZmoktdHHuG//W3us9S7SXbM
         QiXF9pMfegmcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npQkx-0007KW-83; Fri, 13 May 2022 10:34:39 +0200
Date:   Fri, 13 May 2022 10:34:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] tty/serial: termbits cleanups
Message-ID: <Yn4YHyTDBJTOtGsQ@hovoldconsulting.com>
References: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 13, 2022 at 11:29:01AM +0300, Ilpo Järvinen wrote:
> A few simple cleanups that I've come across while playing with the
> termbits.
> 
> v2:
> - Make shortlog simpler
> - Note when in the history ifdefs became unnecessary
> - Balance braces
> - Remove extra parenthesis from the same lines

Thanks for the update.
 
> Ilpo Järvinen (5):
>   tty: remove CMSPAR ifdefs
>   tty: remove BOTHER ifdefs
>   tty: remove IBSHIFT ifdefs
>   serial: fsl_lpuart: Remove unnecessary clearing for CRTSCTS
>   serial: jsm: Use B0 instead of 0
> 
>  drivers/char/pcmcia/synclink_cs.c   |  2 --
>  drivers/tty/amiserial.c             |  2 --
>  drivers/tty/mxser.c                 |  5 ++---
>  drivers/tty/serial/8250/8250_port.c |  2 --
>  drivers/tty/serial/fsl_lpuart.c     |  8 +++----
>  drivers/tty/serial/jsm/jsm_cls.c    |  8 +------
>  drivers/tty/serial/jsm/jsm_neo.c    |  8 +------
>  drivers/tty/serial/sunsu.c          |  2 --
>  drivers/tty/tty_baudrate.c          | 35 +++++++----------------------
>  drivers/tty/tty_ioctl.c             |  2 --
>  drivers/usb/class/cdc-acm.h         |  8 -------
>  drivers/usb/serial/ark3116.c        |  3 +--
>  drivers/usb/serial/whiteheat.c      |  4 ----
>  13 files changed, 16 insertions(+), 73 deletions(-)

For the series:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
