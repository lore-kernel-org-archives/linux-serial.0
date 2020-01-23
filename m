Return-Path: <SRS0=uJPQ=3M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF4C33CB6
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DAD214AF
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579790550;
	bh=1Dn+fl/jr2XOrPxCAJFsmb+RFAJag/5bwntu5/Ek0MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9Bl5nahCAFO9xBWjCkPaEXqi4AZCn17Km5Nrsbw9FgEmGlAG7wDcd2fodQtSka5H
	 U6/klakCJArC6Uz/NCYQC/Wv3jgGywZ1kCQN2FyQqIBiOuZt9K1MSkhwMfzJD3O593
	 g/ozcS455cYPl0n0demkl6FnaB9zktVRHmwnpy24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWOm0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:42:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38600 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgAWOm0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jan 2020 09:42:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so2931793oth.5;
        Thu, 23 Jan 2020 06:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VojjtS7akMpAwcay/UmymGiR2hr9tFaDHzEASOXUD8w=;
        b=qInmoVWZHV918nepi6SS8coqrotGCF1BScJvQq49sl+vNDm3mvSXN5eHsP43sw20M/
         4oxI9rnGW65vUQkl1fJKc6R8iKCEYnELAK73T31p892W0GHs2IE/FnRWHmVJ46dFKwvk
         ORsP5OHmCb438u5OHaPKAxK7FDCdz9g+TJDFyJ9sRVAWQBIrwAb8M9phs80fHnsKMExa
         9Rd4f9SFWlLPgm/NAmbq0Footirgr/UINAMpf57W+pZC10eYCxqmVVSEqL2a3AqknhOb
         ET0+QBl+EEnIK6/UloBZPO1oNC/KG4gznTuSOZfBKqDN2tmNdNwe2H4aaFNceoVXz9VN
         1Ccw==
X-Gm-Message-State: APjAAAVQ8y0zbEjJYwjfyxhsK2Uxe0eWc1Z6SQEOMzc6tR4SxnsKd96s
        k2K5jlmhHk6S8lmvNNMyXzLNDmk=
X-Google-Smtp-Source: APXvYqxykG4E/5TrCk67dHt8GjjUfo7u0vBc/K5VrQHFHH+0sZpSZGqLdxDBl66PpWm84FUIUxD2uw==
X-Received: by 2002:a9d:3e16:: with SMTP id a22mr12080775otd.259.1579790545677;
        Thu, 23 Jan 2020 06:42:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm845782otk.25.2020.01.23.06.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 06:42:25 -0800 (PST)
Received: (nullmailer pid 9469 invoked by uid 1000);
        Thu, 23 Jan 2020 14:42:24 -0000
Date:   Thu, 23 Jan 2020 08:42:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        erwan.leray@st.com, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: Convert rs485 bindings to
 json-schema
Message-ID: <20200123144224.GA9094@bogus>
References: <20200122095558.22553-1-benjamin.gaignard@st.com>
 <20200122095558.22553-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122095558.22553-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 22 Jan 2020 10:55:57 +0100, Benjamin Gaignard wrote:
> Convert rs485 binding to yaml style file.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - remove types inside rs485-rts-delay property and add a maximum for delay
>   values
> 
>  Documentation/devicetree/bindings/serial/rs485.txt | 32 +--------------
>  .../devicetree/bindings/serial/rs485.yaml          | 45 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/rs485.yaml
> 

Applied, thanks.

Rob
