Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB91C282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C86620673
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 21:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fKt6naZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgAJVtN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:49:13 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:40789 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgAJVtN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 16:49:13 -0500
Received: by mail-pj1-f49.google.com with SMTP id bg7so1535954pjb.5
        for <linux-serial@vger.kernel.org>; Fri, 10 Jan 2020 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EotSuVC8x//6WTz5AWaS7rsTrdlhebSai/ftb1+E4dE=;
        b=fKt6naZQW/i9MFnHyjX9n+cMX+BtPuQ15JIY49Lo5XG3ArYZnRKVndhMOvZUsPFsL7
         oW4ZIWE1UL25OmBc2pVmcVbHDSHyOLkloQGKjEDdAvaFQ5Ky/88HFbJQkjZXbvUKH62z
         Qjk/RpYqzaPVVqgVFQG4MIv9vC6BK0Q/Px/qla8lfUTsYQult063a0PPGT8DRuCxRODV
         dDh5qAt3YEHWQU1N6UsL2gyR0eu2K1BubJzcDd1XvHeUwiWOMh/ID34i44htTR3J/o0b
         FL9RHX7aEGle2QbQStPWiqBXXVUVzeQ4qg87Mk2Hi1S0elpTa/bAbEXpw4ezcQ85S3F1
         4wKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EotSuVC8x//6WTz5AWaS7rsTrdlhebSai/ftb1+E4dE=;
        b=mrtoyxNrkfMerj6xpa9MDpblNrR7PJFdVgJCIVvta92EgeNMlAZucDlBhZfUd9Sfok
         T0Hw0yv3hbFBjNvYF32PVrlEY2nciYaMc2wzt7qgObIIE+RJTrpakJ/4Gw6TCs+S1JfM
         D1xAzKOqiglob3uON/DHoiVnpSNKt83eSC00ReQGJXXtStqT5vlWPgUkqIpAm9vSDCEi
         RqQYJ42LmmSqnPBgllGcJ31WPNyc/3FrCH1kbijmbYOtwsRS2WC/irQ2eAXnZouH6FIB
         EpWLLSePT6btnppGkzFBxKkEdhPYjOwzMXpFD2TTo+6dAQ03irV4zLMu7pU9vW9nPfsj
         GvCA==
X-Gm-Message-State: APjAAAWoExYoBQLbJd4mk6Y04GlgVFXoylKumvwfRwRBX/cy7qk8e8UK
        51vqJ9RNXl65Te8AtbQqhfbNBw==
X-Google-Smtp-Source: APXvYqwRu265Y3X0hs9bzTfjAnTlPhZVFYgk8do4sgggN/Ov+FCjgdLdT0ymGoEG3OhqL/pp3neC+Q==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr6720859plt.306.1578692952197;
        Fri, 10 Jan 2020 13:49:12 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 3sm4128337pfi.13.2020.01.10.13.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:49:11 -0800 (PST)
Subject: Re: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-3-dima@arista.com>
 <CAAXuY3rENaHb9yAgdaKRi4A8qQ5QNX8z6WBJRsNM0EVuReL8Qw@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <f2a2a255-a078-68fc-9e5b-91b4ecc749ba@arista.com>
Date:   Fri, 10 Jan 2020 21:48:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3rENaHb9yAgdaKRi4A8qQ5QNX8z6WBJRsNM0EVuReL8Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Iurii,

On 1/10/20 3:19 AM, Iurii Zaikin wrote:
> Off topic: I wonder if Magic Sysrq could be extended with reasonable
> effort to be triggered by a sequence of keystrokes which would be less
> likely to be generated by a noisy serial.

That's what I do in 3/3 patch from the series:
https://lkml.kernel.org/r/20200109215444.95995-4-dima@arista.com

Or do you mean something else?

Thanks,
          Dmitry
