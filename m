Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86904C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Apr 2022 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbiDGO1T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbiDGO1S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Apr 2022 10:27:18 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275E187B89
        for <linux-serial@vger.kernel.org>; Thu,  7 Apr 2022 07:24:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i15so5113297qvh.0
        for <linux-serial@vger.kernel.org>; Thu, 07 Apr 2022 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vlSZXPc/WWB6O0Ntn/+6VGgM4mQ/P1gNa/KkL6kCL7M=;
        b=oeGPjNgtHVvKBxNMhG8G4Q8QuOtzWGHoB4yEDz/eqEuoLw4MoKrJV0Cu3zGSYz9kKw
         HVroEobn9e+OLjnrG12dG9ZFzIfqeETZYJZxwSrKNz7g0IG8De4hOMEkfSHY/z0Zejfj
         H1JlCxOss9whUG21mymflAK/TnzsF6V7KXt+IyKDTNevlzVXa2wn+6I48Nh6SdUCVmjd
         aiNXnTtKVoinWgCb2wJ7v3Qi0EOZlwzRriDJb7MKWBJ0CnXgrVJYJLMXgdiyy+v5tHHh
         41RpzdJsqTxqfiMUA/+gw2XoYaVRuDwkFqVtwMLYuXJ4pf560ZK2xU2By+QSLoO4DrjQ
         Ga+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vlSZXPc/WWB6O0Ntn/+6VGgM4mQ/P1gNa/KkL6kCL7M=;
        b=SYPpjaNXhsqhOYYDcWLMIWn+Lx+uI06FCKq4QqxG8vyjx89ncXYwk6uTb8FkseH2d+
         IzlAEb5wwD9W2hPn4l4ZmKbyU1jd2TJXp/V2zY70eCRG/abbpJYR7n7NdWUxKHY5/Rrx
         pQMrOaOYQQFd9mtNkVNPxaW5c7oXh5EyBFtitbbrVt6KnNrwWwCefKvXVbIKA+KZiz2V
         6TxFRqpkfjEr6Hcn05XIK5+J99yDeiTnVh7F7hv4bXCCPQIvreAU6UrvvBycFpv8Cd+c
         /iASaWd7Vnix9VaLV/JXsYI9DMPENEz2KaPz/AlqYFjpYrPLuLxzyq4CCsW4CEnJMcOP
         PL3A==
X-Gm-Message-State: AOAM531L9kPD+TtiOLpPxjKKMJe2L9P3drDVcQpgzz5bX0Rkfj/lXaO/
        hhlyrJ/ubwIy4jAZyccGehM2Mg==
X-Google-Smtp-Source: ABdhPJwBTVSbg6sLzWrCS9NGMS5EzxPSS5wkz2ckXLOjrhXFly+LUsn4jydlD/Qq90o6V5TmAN5lHw==
X-Received: by 2002:a0c:a942:0:b0:443:a395:cc1f with SMTP id z2-20020a0ca942000000b00443a395cc1fmr11910876qva.68.1649341438080;
        Thu, 07 Apr 2022 07:23:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a0b0300b00699c6a9b2d1sm7135084qkg.32.2022.04.07.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:23:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ncT3D-00EF1o-Ui; Thu, 07 Apr 2022 11:23:55 -0300
Date:   Thu, 7 Apr 2022 11:23:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     duoming@zju.edu.cn
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, jes@trained-monkey.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alexander.deucher@amd.com, linux-xtensa@linux-xtensa.org,
        linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-hippi@sunsite.dk,
        linux-staging@lists.linux.dev, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: Re: [PATCH 09/11] drivers: infiniband: hw: Fix deadlock in
 irdma_cleanup_cm_core()
Message-ID: <20220407142355.GV64706@ziepe.ca>
References: <cover.1649310812.git.duoming@zju.edu.cn>
 <4069b99042d28c8e51b941d9e698b99d1656ed33.1649310812.git.duoming@zju.edu.cn>
 <20220407112455.GK3293@kadam>
 <1be0c02d.3f701.1800416ef60.Coremail.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be0c02d.3f701.1800416ef60.Coremail.duoming@zju.edu.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 07, 2022 at 08:54:13PM +0800, duoming@zju.edu.cn wrote:
> > > diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
> > > index dedb3b7edd8..019dd8bfe08 100644
> > > +++ b/drivers/infiniband/hw/irdma/cm.c
> > > @@ -3252,8 +3252,11 @@ void irdma_cleanup_cm_core(struct irdma_cm_core *cm_core)
> > >  		return;
> > >  
> > >  	spin_lock_irqsave(&cm_core->ht_lock, flags);
> > > -	if (timer_pending(&cm_core->tcp_timer))
> > > +	if (timer_pending(&cm_core->tcp_timer)) {
> > > +		spin_unlock_irqrestore(&cm_core->ht_lock, flags);
> > >  		del_timer_sync(&cm_core->tcp_timer);
> > > +		spin_lock_irqsave(&cm_core->ht_lock, flags);
> > > +	}
> > >  	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
> > 
> > This lock doesn't seem to be protecting anything.  Also do we need to
> > check timer_pending()?  I think the del_timer_sync() function will just
> > return directly if there isn't a pending lock?
> 
> Thanks a lot for your advice, I will remove the timer_pending() and the
> redundant lock.

Does del_timer_sync work with a self-rescheduling timer like this has?

Jason
