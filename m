Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B98C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0967361073
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhDOVNi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:13:38 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44763 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhDOVNi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 17:13:38 -0400
Received: by mail-oi1-f181.google.com with SMTP id e66so10413765oif.11;
        Thu, 15 Apr 2021 14:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FAWw3bFQYesjQeXkR8MC2exPHbWdji9I901Slad01Hg=;
        b=d8okGdcVEXXxd0u5gUAgezkZDDakOHjyhckq2J5MHqzUonVK1g0H6CcNVLD7I434wN
         1z8p9y3QkzZMaKwzLTiR3YBsPY2s2BZwzPkmSreIy1Hv38gUdu3EYypG04XQdfK3WkG7
         EavsXriBcDNQWGTqnAJuaU6AdtsQamu5dQxQaCkoRIy81nF+ePq/BaIRCY9CC54a5AHU
         KN51OpNKftoUXZvK0FPMyeNk+Ix2NAaguSgQZCjZPJeh7Q+qlD9KvJ06Fcis75aP3TLR
         Id8q6eWRGIDthiEWkSJVP+Pp6roO4As2HoiYKeVIeElcNvLOppfVxOmdfK/9y+wxNYsa
         /oTg==
X-Gm-Message-State: AOAM533XEjDVCiSRJD1cwxHS6sc2DMv3imQwXFXZRMTNX8r6mEBX+vOj
        hn6YKGEp++ANlTDgOICB/w==
X-Google-Smtp-Source: ABdhPJwzFYNQydxVA8BPBy4H6gxtdqg8s1DYtgAHX093Huw036nQO182IDJQe7+iCFZzEnNtZ654Bg==
X-Received: by 2002:a54:468b:: with SMTP id k11mr3831622oic.85.1618521194161;
        Thu, 15 Apr 2021 14:13:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b12sm890849oti.17.2021.04.15.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:13:13 -0700 (PDT)
Received: (nullmailer pid 1892163 invoked by uid 1000);
        Thu, 15 Apr 2021 21:13:12 -0000
Date:   Thu, 15 Apr 2021 16:13:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: 8250: update TX FIFO trigger
 level
Message-ID: <20210415211312.GA1892117@robh.at.kernel.org>
References: <20210413174015.23011-1-erwan.leray@foss.st.com>
 <20210413174015.23011-4-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413174015.23011-4-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 13 Apr 2021 19:40:14 +0200, Erwan Le Ray wrote:
> Remove data type from tx-threshold trigger level as defined now as a
> serial generic property.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>
