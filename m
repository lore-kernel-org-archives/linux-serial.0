Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2435EE5
	for <linux-serial@vger.kernel.org>; Tue,  9 Jan 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivSDlzda"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd33336b32so36176461fa.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jan 2024 02:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704796106; x=1705400906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUr/EtqYKhPPkSCGThDWr7qu4w+7krnoVLWEAa93xr8=;
        b=ivSDlzda8UlN32yvW0o4xvqqMLzfK0UpINl0Jgzo2pPbaBieUHR8JKQ8xZCg6Awx/5
         eEfiwBN3El7iKpBGLf9S+D2pNCdJZQ8oIFhzDU1YwtbBx6sgwlZMnpO2cgGHitsTQxnq
         1VswXmRu1iCW/eUBL2aSzdTDlrfHoYXmqFLI7lKwHFIP0Hm3aEJpghyb74jBKqhqxNo6
         j5IhDOEV9YLJj5OLf5aIsKXZOj7SnA9kVMv4VkZPXRKryyqX50PDAh/asAEzEaxRuUlB
         VDwb2ezWWmqNWso9WMib0OZGZXrTV51URvmXpvGR1M09g4PGx05XbWZQonWDeBzbGCd8
         i+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704796106; x=1705400906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUr/EtqYKhPPkSCGThDWr7qu4w+7krnoVLWEAa93xr8=;
        b=fj+QvT1kWJcmMb2SKJORYyyt9b3mCw1JbR0ln8GDmBrT88i6c2PNhSuMDFqWhUjo6d
         V7NIbjyBZQEnst3LkqF1zD9Wh4y0UG5EyeCxXSfUBZyvVBUqf6MdnMXJlEH5sKBAHkuW
         Ozdth9wkXy9Xdb/cVfkJrwFvPdaiviMgWJRLxWAZsmFhT06aIAQGdKUKSQrR7jCzD9OX
         3IHNOLfA4pB0hcy/rzT8VTTRz10hbUPsdjzKGP4Q5AhF27x3ezdocJ1dxGy2cwtngxHl
         9oOpNlQPMExPqlHjgFCzIdLyDXtYyvihWSEWrLTiCzPz8axjLS+ga3JwOMHiYQby9SfR
         wcjg==
X-Gm-Message-State: AOJu0YyE3fEZ9WUtgo464STvjZHbMfQevp69kXFiRyWvIj7PyWw/1Itv
	5q8bNhi/4H3G/Om0xs+FWOSNuOOJYSIQtPfH
X-Google-Smtp-Source: AGHT+IFv9VD7TelcAhQKgEvbd+XCwvUHGUm3grAarbNJ56JcU5vLfdkJE3lUa19tDuEKaHNj8iJ5dg==
X-Received: by 2002:ac2:48a6:0:b0:50e:beb0:5f96 with SMTP id u6-20020ac248a6000000b0050ebeb05f96mr1585868lfg.46.1704796106070;
        Tue, 09 Jan 2024 02:28:26 -0800 (PST)
Received: from [192.168.1.2] (ip4-83-240-121-90.cust.nbox.cz. [83.240.121.90])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906301300b00a289d772555sm872958ejz.66.2024.01.09.02.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:28:25 -0800 (PST)
Message-ID: <0f1b1a68-31de-46db-ba4a-dca4f3579495@gmail.com>
Date: Tue, 9 Jan 2024 11:28:24 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty/vt: UTF-8 parsing update according to RFC 3629,
 modern Unicode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, roman.zilka@gmail.com
References: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
 <2023121201-ecosphere-polyester-8d37@gregkh>
 <834b6344-55dd-4a92-b1db-8d60d2b40a3e@gmail.com>
 <e5e7fd4f-acac-41a0-8a36-1f4f71eb7c18@gmail.com>
 <2024010413-quickly-crinkly-6c5b@gregkh>
Content-Language: en-US, cs-CZ
From: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>
In-Reply-To: <2024010413-quickly-crinkly-6c5b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/4/24 4:28 PM, Greg KH wrote:
> On Tue, Dec 12, 2023 at 09:26:53PM +0100, Roman Žilka wrote:
>> vc_translate_unicode() and vc_sanitize_unicode() parse input to the
>> UTF-8-enabled console, marking invalid byte sequences and producing Unicode
>> codepoints. The current algorithm follows ancient Unicode and may accept
>> invalid byte sequences, pass on non-existent codepoints and reject valid
>> sequences.
>>
>> The patch restores the functions' compliance with modern Unicode (v15.1 [1]
>> + many previous versions) as well as RFC 3629 [2].
>> 1. Codepoint space is limited to 0x10FFFF.
> 
> Wait, why?  And shouldn't this be an individual patch on it's own?  What
> is wrong with the checking we currently have.

This is the main point of this patch. The codepoint space got shortened in Unicode at some point between v3.0 (1999) and v4.0 (2003). The reason why is expressed by the first sentence in the commit msg. The affected functions validate input coming into the subsystem from the user, which makes it a red flag that they do not do so correctly (i.e., according to a generally accepted standard). As they stand, these functions are a potential source of compatibility and security issues. The may not be a bomb, they may be a time bomb.

Note how very old the old parsing algorithm is. I made a quick grep of the kernel source for tell-tale signs of utf8 parsing to see if there's any other place where the old algorithm is still being used. I found none, and I found these which do the 0x10ffff limiting (I didn't check the "noncharacters" handling):

fs/unicode/mkutf8data.c
fs/unicode/utf8-norm.c
fs/udf/unicode.c
fs/nls/nls_base.c (has many users outside fs/)
drivers/tty/vt/keyboard.c

I didn't check, but I have no doubt that Perl implements Unicode correctly as well.

>> 2. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in
>>    Unicode and will be accepted.
> 
> Accepted when?

Currently, the two affected functions mark these codepoints as invalid by substituting them with the placeholder U+FFFD. After the patch, U+FFFE and U+FFFF are treated as ordinary valid codepoints.

Let me point out that I've never seen a utf8 validator where "noncharacters" were treated in a special way. Of course, there're only so many validator implementations that I have seen. Checking for iswprint()-ability is common, but that's something very different. IMHO, the validator in vt.c is not a place to pay any special regard to "noncharacters".

>> Another option was to complete the set of
>>    noncharacters (used to be just those two, now there's more) and preserve
>>    the rejection step. This is indeed what Unicode suggests (v15.1, chap.
>>    23.7) (not requires), but most codepoints are !iswprint(), so selecting
>>    just the noncharacters seemed arbitrary and futile (and unnecessary).
> 
> What is this change going to break with existing systems that were
> thinking these were invalid characters?

This is mostly answered above. I don't work with the kernel in a developer capacity. I found this parsing error by accident while researching some CONFIG options. I'm not qualified to say that this patch won't break anything and it would take me an abhorrent amount of time to verify that to a reasonable degree. I don't write code for kbd or other console-related userspace tools either. I ran the patched kernel for a while, played around with fonts and various TUI utilities. I found no issues. The red flag, which I talked about earlier, was _the_ reason I submitted my patch.

>> On the side:
>> 3. Corrected/improved the doc of the two functions (esp. @rescan).
> 
> Again, a separate commit.  When you have to list the changes out, that
> is a huge hint it needs to be broken up into smaller pieces.

Ok, patch v4 coming up with this removed and I'll take care of it in a subsequent submission. That'll be one truly trivial commit, though.

-rz
