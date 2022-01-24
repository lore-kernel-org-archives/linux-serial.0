Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9FC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 24 Jan 2022 09:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiAXJwH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiAXJwG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jan 2022 04:52:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A125C06173B
        for <linux-serial@vger.kernel.org>; Mon, 24 Jan 2022 01:52:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v13so12422139wrv.10
        for <linux-serial@vger.kernel.org>; Mon, 24 Jan 2022 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YxzpAzBqVcr2hi+2O2BL/6LRftj9YBJf90csHpml1gY=;
        b=IosfrhSwyj4lCYYO4dRbRM1xXDqpk9cPobHA/OKkRULepcE9JY+9cNsj3oeChirbl6
         0tipFCTaukfr1+BDf3L3lAHdeGU6TfCRZgO28nNb4SqjCZ7OkI9V5fR5ssdhC/ee1Vph
         m30QZPrOLLBeTXK/CLf8c5mUWEyJRKtvhlbT9jIRMrz8g/tDqaRPB8q6rmL3DpDTtixf
         m6ktnFBtpkmJ2hITVJRCSOcXo6e9kRW33KTZdKcHIg3Nfnxn3FrvJBbhi7d9DlOOf5Yn
         6+JXvgaieT48wtMtNHOPsF+B6y2UnKj15Q4UB9mkmQnPLEmOXTHy3rrCRHmYCQpNcDO4
         jT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YxzpAzBqVcr2hi+2O2BL/6LRftj9YBJf90csHpml1gY=;
        b=21lKTPrG+VrnnDGfnyIKjKKFIf7eT7QfTLxhgJnKQrHrjgge9lrBAp2NIlBD2Uv653
         MwT4aO4uixr30GVF7LUeNLTvoZoWpLyTGh8sehZShtMQgjDV/bpHJ3dnuKU3G5VlfdyU
         h/+3z2Nx/6+g52nAJrw07H44/SAdUzF5kpbKvT3lIj1xVkdxkOKxunJlgkpC6L4SlBOd
         lDEixwUGIHn7VuZYH2CQvZAol2wFhtM8m3I+c8DPPn1O808w+NxftoY9J3XRhhzWYjrj
         kv3RqVmWI+AvlGbAKYuIeiQVh7V+CcEY0DxqT3O39Vss/hwjMEBIcDfYRsAOjUPM/rxE
         UPbg==
X-Gm-Message-State: AOAM530Tmvs1PDBk6uSG11Oi2FordhDwRHFgCzqW3WRW7hhLNZP62uFJ
        arLSgBk4pNfhA+/L9My0RrRUJUo/TYSaFg==
X-Google-Smtp-Source: ABdhPJym4z61Dr6Q8ApJ/f6yhLFpVYE08dzAoXWiwgG3TTZOZVIZMxpTygVFRu1z8ql7Dlp1xfJyWw==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr3828727wrq.398.1643017924515;
        Mon, 24 Jan 2022 01:52:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id 5sm8469668wrb.113.2022.01.24.01.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:52:04 -0800 (PST)
Message-ID: <c66ae9ce-7345-736c-010e-1dd5602b67df@gmail.com>
Date:   Mon, 24 Jan 2022 10:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Modem control lines for RTSCTS hardware flow control via rts-gpio
 and cts-gpio with IMX
Content-Language: en-US
To:     =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-serial@vger.kernel.org
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
 <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
 <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi,

Le 14/01/2022 à 07:19, Tomasz Moń a écrit :
> On 14.01.2022 04:08, Tim Harvey wrote:
>> So I believe in order to support using gpios for rts/cts in the imx
>> uart driver I must find the right place to call imx_uart_rts_active
>> and imx_uart_rts_inactive when the FIFO is not full and full
>> respectively. I'm not that familiar with the Linux uart driver
>> framework - am I on the right track and if so any ideas where this is
>> best done?
> 
> It is not really the driver (and thus FIFO level), but rather the amount
> of free space in tty buffer (checked by Line Discipline workqueue) that
> determines when to throttle (set RTS inactive). This mostly works fine,
> but fails [1] when the RX interrupt frequency is too high [2].
> 
> The throttle/unthrottle request, when termios CRTSCTS is set, is seen by
> the driver as the call to .set_mctrl (imx_uart_set_mctrl) with TIOCM_RTS
> bit cleared/set in mctrl parameter. Currently imx_uart_set_mctrl() only
> controls the UCR2_CTS and UCR2_CTSC bits based on mctrl.
> 
> To support your case you would most likely have to add the gpio handling
> in imx_uart_set_mctrl(). However, I am unaware what other issues you
> might encounter (i.e. if it is not done there yet simply because nobody
> had that use case or if there is some deeper problem).
> 
> [1] https://lore.kernel.org/linux-serial/10e723c0-a28b-de0d-0632-0bd250478313@camlingroup.com/
> [2] https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomasz.mon@camlingroup.com/
> 
> Best Regards,
> Tomasz Mon
> 

I'd suggest to start testing with a serial port connected to nothing, and check the pins values
with a scope or a voltmeter.
Setting pins values from userspace can done quite easily with :
#include <unistd.h>
#include <termios.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void usage(char *prog)
{
	printf("usage: %s serial_port id 0/1 sleep_time_sec\n", prog);
	printf("%s\n", "1:DTR	DTR (data terminal ready)");
	printf("%s\n", "2:RTS	RTS (request to send)");
	printf("%s\n", "3:Both");
}

int main(int argc, char **argv)
{
	int fd;
	unsigned status = 0;
	int enable;
	int err;

	if (argc < 5) {
		usage(argv[0]);
		return -1;
	}

	fd = open(argv[1], O_RDWR | O_NOCTTY);

	enable = atoi(argv[3]);

	if (fd < 0)
		return -1;


	switch(atoi(argv[2])) {
	case 0:
		if (enable)
			status |= TIOCM_LE;
		break;
	case 1:
		if (enable)
			status |= TIOCM_DTR;
		break;
	case 2:
		if (enable)
			status |= TIOCM_RTS;
		break;
	case 3:
		if (enable)
			status |= TIOCM_DTR | TIOCM_RTS;
		break;
	default:
		printf("unknown signal\n");
	}

	err = ioctl(fd, TIOCMSET, &status);
	sleep(atoi(argv[4]));
out:
	if (fd > -1)
		close(fd);

	return err;
}

regards,
Richard
