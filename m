Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34C0C4363D
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 23:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6017A214F1
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 23:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIuAB5Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWXnM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 19:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXnM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 19:43:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8E2C0613CE;
        Wed, 23 Sep 2020 16:43:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so1961656ejb.4;
        Wed, 23 Sep 2020 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gTCQ6FmbtqXr2lWYi2SA92VBSqB0+yg7rI8urwU4EPQ=;
        b=GIuAB5Gf+EQXOBC+oUffPLM/u/Ny+yaZHgdkRxzMUIYycsGcIRBgEz6S6H32yT5SG/
         3y0daOEPOh0ZdPkEYg+qpA5IJ2AzUPaMl2kJabgSid7hPCi04pb/fTIa/RNHyjOX8N/B
         zTPujNrL3fYTeJ6Pyl+J3PpyDRWs0J7r/wPG2NwARq4hHV1D8S6QcSzc19at3t04ubZe
         ZysCzDVzvPMbFSwHZ6kUFDVzWVkNRjzPxe72i8xDynUG2OL4fqS2gXCkrU4uUPy5x03z
         YOranh+9jwvCWccxq354q/SJiFub/8j3DwYgLXFA2FbAKFW/Un9VA6O6LMYR45pgDDZE
         u7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gTCQ6FmbtqXr2lWYi2SA92VBSqB0+yg7rI8urwU4EPQ=;
        b=bU0NChSPDeOQL/yQY4NLu4/kDVF94vM6Y+1eghb8HQjZ2bYoDXIt9GUt6Frdygb0/J
         XXp2DXVXCRKdzc95brtxYynafv/KxiAUn5/dunv/nm2Ov4qCghEym+VBASeGZbOQyK2w
         1RSdCnqz0XwcRNl/VXo3+WnNPpV5kU1gTqOgKYPcBDUMZtavmeeEacZjyWXPdKRFQoDe
         NZIT2L9hPNUrmVF6nSK6wXG8fgh44mf7/1WMUPuXoFLsk0fk6l4OZ3xcoYv4rtgzYmbJ
         iEJ/PTdxYaoqOMAmKJ6wPq173dFyx4hnlYuUmLK5202UWy60UEc57CeC8/a8EET/kZ+x
         yA7A==
X-Gm-Message-State: AOAM532dM78A8kLuHeACvXyuldUUHGPQ9Mm3P4jSyV6ohQIrd6MZjSaF
        d++hKjoLyO5Eo5Ou7poa71E=
X-Google-Smtp-Source: ABdhPJyBcZOwL1UAV6einIScXJQW7Azt3W1QKVNAZG3ADffqAfkH8MNFxJpP7x/4rn3kD2KFZPAoDg==
X-Received: by 2002:a17:906:7fcc:: with SMTP id r12mr2022196ejs.360.1600904590831;
        Wed, 23 Sep 2020 16:43:10 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id e25sm999772edj.43.2020.09.23.16.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 16:43:10 -0700 (PDT)
Subject: Re: [RFC PATCH 4/9] surface_aggregator: Add trace points
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-5-luzmaximilian@gmail.com>
 <20200923160757.51e773a0@oasis.local.home>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <dad57e7f-7f3c-7fea-0fbf-a32006da52b6@gmail.com>
Date:   Thu, 24 Sep 2020 01:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923160757.51e773a0@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 9/23/20 10:07 PM, Steven Rostedt wrote:
> On Wed, 23 Sep 2020 17:15:06 +0200
> Maximilian Luz <luzmaximilian@gmail.com> wrote:
> 
>> Add trace points to the Surface Aggregator subsystem core. These trace
>> points can be used to track packets, requests, and allocations. They are
>> further intended for debugging and testing/validation, specifically in
>> combination with the error injection capabilities introduced in the
>> subsequent commit.
> 
> I'm impressed! This uses some of the advanced features of the tracing
> infrastructure. But I still have some comments to make about the layout
> of the TP_STRUCT__entry() fields.

Thanks!

[...]

>> +DECLARE_EVENT_CLASS(ssam_packet_class,
>> +	TP_PROTO(const struct ssh_packet *packet),
>> +
>> +	TP_ARGS(packet),
>> +
>> +	TP_STRUCT__entry(
>> +		__array(char, uid, SSAM_PTR_UID_LEN)
>> +		__field(u8, priority)
>> +		__field(u16, length)
>> +		__field(unsigned long, state)
>> +		__field(u16, seq)
> 
> 
> Order matters above to keep the events as compact as possible. The more
> compact they are, the more events you can store without loss.
> 
> Now with SSAM_PTR_UID_LEN = 9, the above is (on a 64 bit system);
> 
> 	9 bytes;
> 	1 byte;
> 	2 bytes;
> 	8 bytes;
> 	2 bytes;
> 
> The ftrace ring buffer is 4 byte aligned. As words and long words are
> also 4 byte aligned, there's not much different to change. But it is
> possible that the compiler might add 4 byte padding between the long
> word "length" and "priority". Note, these are not packed structures.
> 
> Testing this out with the following code:
> 
>   $ cat << EOF > test.c
> struct test {
> 	unsigned char array[9];
> 	unsigned char priority;
> 	unsigned short length;
> 	unsigned long state;
> 	unsigned short seq;
> };
> 
> static struct test x;
> 
> void receive_x(struct test *p)
> {
> 	p = &x;
> }
> EOF
> 
>   $ gcc -g -c -o test.o test.c
>   $ pahole test.o
> struct test {
> 	unsigned char              array[9];             /*     0     9 */
> 	unsigned char              priority;             /*     9     1 */
> 	short unsigned int         length;               /*    10     2 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	long unsigned int          state;                /*    16     8 */
> 	short unsigned int         seq;                  /*    24     2 */
> 
> 	/* size: 32, cachelines: 1, members: 5 */
> 	/* sum members: 22, holes: 1, sum holes: 4 */
> 	/* padding: 6 */
> 	/* last cacheline: 32 bytes */
> };
> 
> You do see a hole between length and state. Now if we were to move this
> around a little.
> 
>   $ cat <<EOF > test2.c
> struct test {
> 	unsigned long state;
> 	unsigned char array[9];
> 	unsigned char priority;
> 	unsigned short length;
> 	unsigned short seq;
> };
> 
> static struct test x;
> 
> void receive_x(struct test *p)
> {
> 	p = &x;
> }
> EOF
> 
>   $ gcc -g -c -o test2 test2.c
>   $ pahole test2.o
> struct test {
> 	long unsigned int          state;                /*     0     8 */
> 	unsigned char              array[9];             /*     8     9 */
> 	unsigned char              priority;             /*    17     1 */
> 	short unsigned int         length;               /*    18     2 */
> 	short unsigned int         seq;                  /*    20     2 */
> 
> 	/* size: 24, cachelines: 1, members: 5 */
> 	/* padding: 2 */
> 	/* last cacheline: 24 bytes */
> };
> 
> 
> We get a more compact structure with:
> 
> 	TP_STRUCT__entry(
> 		__field(unsigned long, state)
> 		__array(char, uid, SSAM_PTR_UID_LEN)
> 		__field(u8, priority)
> 		__field(u16, length)
> 		__field(u16, seq)
> 	),
> 
> 
> Note, you can find pahole here:
> 
>     https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> 
>> +	),

Thank you for that detailed write-up! As you have clearly noticed, I
have not really looked at the struct layouts. I will fix this for v2,
include your changes, and have a look at pahole.

[...]

Thanks,
Max
