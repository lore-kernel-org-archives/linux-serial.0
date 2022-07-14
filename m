Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F76C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiGNL7S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiGNL7R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 07:59:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0205B058
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 04:59:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y11so2401885lfs.6
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EgRB3uk2eARor0EOATA0atI967xULo2Iq5wahJWcNKY=;
        b=pkSdn509huWe8QwssIYCQ/3Et0ZHqT9xt2lBSNjiyBPfMyHLI0D/AzlBAZzNQ8Oqit
         HI49Vyrrv9K76vvbwoPjp5q83eyoUXws593RmU18+ZOBk1YQyB7vUed46vZ/gMtHJYO6
         mqavqHLW7rQ/i/2FOvW69MuddpBVojxD9MjUDWkNgvCTw4wA5xTgIrTZDBYFbA3RKNXz
         qT6pnqyN5FcgP7k4rCJEBBQA2unaPQOmBBZUxe0uyJgLGOPsVhYlyRx80WzSjnE3674W
         EIjNKOIQBZ7t+XXj++lqZkY09ZP8DWh6J6SvrY4dI3GIfqqemBA20bahTcJixbzU3OYR
         9bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EgRB3uk2eARor0EOATA0atI967xULo2Iq5wahJWcNKY=;
        b=SnS91JgJ2ibDZKlWaXkgabdQAggLwUEy58w//sGGxF7V/lHcVut69Me4WvJ+wXfmxl
         2nxEzEzzWE4SUB11hwAK6uIratfwqEOx+wu0DXnjQZSqUEYu7rD+NZrCMhEJTPHwpvmV
         YGUXMUSIKbsASUnuD97GbiXp5Rc9Eu/8yMZnBLZNtRK8teQHgAgITnqiGn+IkdJMXNJ7
         OFE2ZdwHGUfpyDG7IUx97rqTD7Uug7bFmTnq0e/qQ/nfxm3ZSWiK8FJ3N8OAa9ZQttxW
         4V0po6Rqbr+GKD+af63haY/pa9i2ZrECINtelSYslf8FyDJPHr6K9X0AIePeeA6SaPmV
         TIhA==
X-Gm-Message-State: AJIora/pM1U1oN3ms3ilUsswz1f/BIn6/eNiDOLdHKuzp6ueuzSZXg/x
        Y086Rgcvs3zviZN/u/UnK5W/oQ==
X-Google-Smtp-Source: AGRyM1sp46qLjUaQ39yzSVfZFmt8J6pClvKxTyubHCvrRm+wHU/jVtGoxJMsm79yrYOE2Ii5U/62Rw==
X-Received: by 2002:ac2:420b:0:b0:489:eac1:5d7f with SMTP id y11-20020ac2420b000000b00489eac15d7fmr5242513lfh.355.1657799954395;
        Thu, 14 Jul 2022 04:59:14 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512324b00b00478f3bb79d6sm322573lfr.194.2022.07.14.04.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:59:13 -0700 (PDT)
Message-ID: <9d9067f3-5b2d-6434-ec2f-93b4a97a6588@linaro.org>
Date:   Thu, 14 Jul 2022 13:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Content-Language: en-US
To:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srinivas Goud <sgoud@xilinx.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org>
 <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
 <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
 <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
 <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
 <CAKfKVtGrdh-iQP7YKUBe37HVeZcU-UV3A3BHKjcnggBFR94eNA@mail.gmail.com>
 <50bfd52b-6fe0-546f-9121-0145aac91289@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <50bfd52b-6fe0-546f-9121-0145aac91289@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/07/2022 12:55, Michal Simek wrote:
> Hi Rob and Krzysztof,
> 
> On 6/14/22 14:21, Shubhrajyoti Datta wrote:
>>>>
>>   <snip>
>>
>>>
>>> No, I don't know what the differences are in your h/w. You have ID
>>> registers, but changed the IP and didn't change the ID registers? How
>>> has the IP changed?
>>>
>>
>> The IP is not changed and the ID registers are not updated.
>> The limitation is coming from the AXI  port that the IP is connected to.
>> The axi port is allowing only the 32 bit access.
>> The same information will be updated in the Versal TRM.
> 
> Can you please give us your recommendation how to process with this?

Unfortunately I don't think that anyone remembers context from last
year, especially me who was not Cced. Rob responded at end of March and
it took two months to get back any answer. Such slow response time from
submitter does not help to stay in the context. :(


Best regards,
Krzysztof
