Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13648C10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 15:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC79208E4
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 15:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0IOSo6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCJP5V (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:57:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgCJP5V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 11:57:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so16535446wrf.10
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqxKcZJOrqeYSSF+8tyd/gsVhc7h6GEjUCuzNcHFAcM=;
        b=T0IOSo6RAe3cFMhsUTvQi/3XfxYHMQKp60imkGrJQygQ7x8SM9uK0zVfHwStDzocz+
         Xu6+o1SVDCx0cONwFl4q7jzXqnUjSDfVZsgV8KAGqm/VE/Yl4xGce5vHkx1XTLxRGNje
         BM7a2qoc/FWhD45o6m0zGHX0VgAt7RkJYtLFCux8UFiTw2vATVzKf9Swk9EcbxqVOiAH
         XQA2K2e4WuntGtIRSoFhJN/AJ/wgnUGrnNUSVqcpOOFW/hncl4Y6nam8mwndGsunIJv7
         6/sDbM0hsBYM8KSEzgn1utxbnO9TbQfcUEHqEuqx6ZQKrAS7neBmW88/Cm18D1Y1O5Id
         ptiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqxKcZJOrqeYSSF+8tyd/gsVhc7h6GEjUCuzNcHFAcM=;
        b=s400Em/u7y11fIDRxA+kyQAnDgYqtFhmE287lnxR4+k+wRpg2eHt9CWAzSFSz+BZzg
         zzhXwGybr7QdcEpvxWa3odKVtfdkGz1Z8O+vDVi8Rmkqehas4mRss39fOVTD/ju7OulF
         AEIAY9Y+ePIulLtJIGjoSSPzH3rQfZESBsdvS41lFoapkurCi/LrM4plI+nzv5PVzeWB
         82qJ+tHVI9jxAHWud3SsHWm8y5kQz2xh5YXuhid/bq75brHS9JRd76gh4SsSyq9oSEDp
         dUMRoFoGYismnJru0G02SPPTS+39cwF5EuPLLAPg7yNwpo3VlKllBUzwnstWQM+oTeNu
         a0rA==
X-Gm-Message-State: ANhLgQ0rxqgriAnC6vpLTfby+9w9A53H0lQGBR7GY1mru1HpEXOKLNLJ
        1HZoTfqd1E0gERBrt+xwwLQ=
X-Google-Smtp-Source: ADFU+vugsoRsjuvoiuX/CEuxMrHQxIhRbKWPA9twtxlRhqEN56ci0XxOcF4+MBvE6gDmZPLUXT036Q==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr26828210wrv.235.1583855839436;
        Tue, 10 Mar 2020 08:57:19 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p16sm3676249wmi.40.2020.03.10.08.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:57:18 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] serial: core: Use string length for SysRq magic
 sequence
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <64f650b7-8c39-4bef-f1d9-ff2720923c8c@gmail.com>
 <20200310145706.GQ1922688@smile.fi.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <c26a1397-6b65-7d80-7fec-cb0f94ff412d@gmail.com>
Date:   Tue, 10 Mar 2020 15:57:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310145706.GQ1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

On 3/10/20 2:57 PM, Andy Shevchenko wrote:
> On Tue, Mar 10, 2020 at 02:38:48PM +0000, Dmitry Safonov wrote:
>> On 3/10/20 1:20 PM, Andy Shevchenko wrote:
>> [..]> @@ -3209,7 +3209,9 @@ static DECLARE_WORK(sysrq_enable_work,
>> uart_sysrq_on);
>>>   */
>>>  static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>>>  {
>>> -	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
>>> +	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
>>> +
>>> +	if (!sysrq_toggle_seq_len)
>>>  		return false;
>>
>> Eh, I wanted to avoid the strlen() call in runtime for every time sysrq
>> is pressed. It's not very frequent moment surely, but..
> 
> I really don't like ARRAY_SIZE() against plain strings.
> This will use \0 inclusively and confuse the understanding the code.

I still feel a bit awkward that handler will run strlen() for something
that could be done compile-time, but I won't insist.

Thanks again for looking into warning,
          Dmitry
