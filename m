Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B481C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jul 2022 22:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiGEWen (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGEWem (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jul 2022 18:34:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29D62D8;
        Tue,  5 Jul 2022 15:34:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so12605915pgs.3;
        Tue, 05 Jul 2022 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7+I4uzJ/2VjMUoauKjA9TnrUXhcNYd0QtO4aLroN08=;
        b=CcybPj2KaNJpXK/5prwzlQtIBlHt3LJMjq0uKBCygnzyD5mQfRUnT+H+gMJfR4/E5/
         xmyQNi9ICa7hpjjrMnNER3qvH3c/b0G4Q4FH3tvaTk2yDAaq5HNz7QzgxCPDJHh2fy+p
         YX/F2JGpcSeoCEG1g+LkITbjeOB7Tny1ninBAqviDIL8HMbgBDBCdNET5Mv0hc5LGwQb
         ToiBOICrDsUTzbwz8g7Ou79Rwndzxk0O1bxuQpS7cuO64oywXBXpP/D55aAU4VriPbAl
         PhOkQ0tV0xRbNtUYfJZWmSA+ZNI0XK59zdk3zpkQ1NSrT9NFR/ee06aMOyKkh728eL8Q
         7LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U7+I4uzJ/2VjMUoauKjA9TnrUXhcNYd0QtO4aLroN08=;
        b=KQW4TJxQ8r/bG69IHVUJPZj9rkMsIWIIZEscwXxG3FnHIft5klJU5/OucxXiGQkwL4
         G4s9ZW34d2/23p+M8TTjMefkZcdMRqHuFnF77AHegNkeA7FZE4aP+kd7F6X3IqAtat66
         VScHNL9qLOKTT8MRJ5U1+WrwF+FYUdlUqFH5Q0aQEIx1Md+2FmLRg3/cz4Cr8RVmyd/a
         Jxi8XNIzfvrqXcPPr9cX75bg9XWlv8wi4iCcvfMfVPNQKQ5Em/djQR47AXnIc6MN91A2
         wb3qT8EHfd9NafP0RbK+eQKxcBCZgCK0cr+bKNyfNvZPhVyMOK8jiottrGZnm7dkUgm/
         hzxA==
X-Gm-Message-State: AJIora+ApA8J8xB9T9yRUgpWWrTg6CvlYKTHzrSUa+XAQ26XQlj/DnlK
        3MLLbkwd20Xor0hauEosfPo=
X-Google-Smtp-Source: AGRyM1tntuwBGW0kqau2E2/Tq7A2893WAOlZj76LS3TfdUyJmhskdN/rJSr7EssN4K5g4EZ79tRCoQ==
X-Received: by 2002:a05:6a00:23ca:b0:525:28b4:9e3b with SMTP id g10-20020a056a0023ca00b0052528b49e3bmr42490538pfc.43.1657060480893;
        Tue, 05 Jul 2022 15:34:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a568])
        by smtp.gmail.com with ESMTPSA id 72-20020a62164b000000b0052893e26fc6sm2098176pfw.25.2022.07.05.15.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:34:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Jul 2022 12:34:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: Re: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Message-ID: <YsS8fin9DVKUGxzM@slm.duckdns.org>
References: <20220701154604.2211008-1-imran.f.khan@oracle.com>
 <Yr9U1q0BBinCgyrT@mtj.duckdns.org>
 <deaaabe5-0a0c-b6f9-c85b-5080874f6437@oracle.com>
 <YsSD4k0o6PPYpMBe@slm.duckdns.org>
 <ea0bc8e3-177c-f78a-de37-339e6261631c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0bc8e3-177c-f78a-de37-339e6261631c@oracle.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Wed, Jul 06, 2022 at 06:18:28AM +1000, Imran Khan wrote:
> In this case, the point of using llist would be to avoid taking the locks in
> consumer.

Given that the consumer can dispatch the whole list, I doubt that's worth
the complication.

> Hmm. My idea was that eventually we will never run into situation where multiple
> producers will end up adding the same node because as soon as first producer
> adds the node (the other potential adders are spinning on kernfs_notify_lock),
> kn->attr.notif_next.next will get a non-NULL value and checking
> (kn->attr.notify_next.next != NULL) will avoid the node getting re-added.

So, here, I don't see how llist can be used without a surrounding lock and I
don't see much point in using llist if we need to use a lock anyway. If this
needs to be made scalable, we need a different strategy (e.g. per-cpu lock /
pending list can be an option).

I'm a bit swamped with other stuff and will likely be less engaged from now
on. I'll try to review patches where possible.

Thanks.

-- 
tejun
