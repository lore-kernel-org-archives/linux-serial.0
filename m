Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D4C83F01
	for <linux-serial@archiver.kernel.org>; Wed, 30 Aug 2023 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbjH3XsH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Aug 2023 19:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbjH3XsF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Aug 2023 19:48:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DAD2
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 16:48:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68becf931d0so169035b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693439282; x=1694044082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6RCq4RR6/qHE9tOsGvlTBAcbhlgpYNipf9zLQX8qUM=;
        b=INcI6ruN12bwO6BAu59eDJJxeneDqAcGayS6zLWJygScQSa63uK1InzPG1WAtR6v2F
         WmygXpRGQyz8BkSPt47ClYb/53c+JwBB5NG1cieSUoa+LHIk1dyZL5MejcbdVjc7wA8e
         PviuRlMaDjBk0OGFHAVRs6sZyamkRJO/22Qec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439282; x=1694044082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6RCq4RR6/qHE9tOsGvlTBAcbhlgpYNipf9zLQX8qUM=;
        b=QqeXLDaNg6NZQKWlaT8btMIPRn0jneq0PoIyQ2Er2KhPQbX71OznDszYul5wI5JMZb
         4SUEtjvFLsJvmNAMJZcqOf7wLbccA/3VhuzeGMwB7+ogQ8pI9rqnvP0Lq8IWfYlmitys
         hlSpHRXqGR2m3/D1rKs0npiyctvSbst54ca3evtxxcVnLO8NtFpQLJs9gtmbKrwjEBmc
         Ubgf6Q/NrKcxZRzdEh7K5GWH8+b4XTXC7WjeH8FlqftaD6fPHA7XuNr34DgFuveIHdRQ
         2dbySmmn7ZG4PJkI2jaCn2HflSMVC4KMEpO/bU+rXurdOrO2iNgxCe8PisCwTypJk3Zy
         q/9Q==
X-Gm-Message-State: AOJu0YyU//edTTvmHQt5MM8AWOP/EUhnxc+ihwX6hmonb6Be60IO/7fh
        0zOJzua1baY0qs1/rPND5dbIKyMUac48eyGgAjE=
X-Google-Smtp-Source: AGHT+IFanA60iEvBGRDslSUvyeX7/DTo8Q3p/34Deh3Ag4hejUKcEDO69EVdfLaKJXqfQAS0Xc7/xg==
X-Received: by 2002:aa7:88c6:0:b0:68b:a137:3730 with SMTP id k6-20020aa788c6000000b0068ba1373730mr3705724pff.26.1693439282060;
        Wed, 30 Aug 2023 16:48:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b006825003a276sm128202pfh.42.2023.08.30.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:48:01 -0700 (PDT)
Date:   Wed, 30 Aug 2023 16:48:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301646.8397A6A11@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
 <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 30, 2023 at 05:17:12PM -0600, Dan Raymond wrote:
> In my opinion strlcpy() is being used correctly here as a defensive
> precaution.  If the source string is larger than the destination buffer
> it will truncate rather than corrupt kernel memory.  However the
> return value of strlcpy() is being misused.  If truncation occurred
> the copy_to_user() call will corrupt user memory instead.
> 
> I also agree that this is not currently a bug.  It is fragile and it
> could break if someone added a very large string to the table.
> 
> Why not fix this by avoiding the redundant string copy?  How about
> something like this:
> 
> ptr = func_table[kb_func] ? : "";
> len = strlen(ptr);
> 
> if (len >= sizeof(user_kdgkb->kb_string))
> 	return -ENOSPC;
> 
> if (copy_to_user(user_kdgkb->kb_string, ptr, len + 1))
> 	return -EFAULT;

This would work if not for func_buf_lock. The bounce buffer is used to
avoid needing to hold the spin lock across copy_to_user.

-- 
Kees Cook
