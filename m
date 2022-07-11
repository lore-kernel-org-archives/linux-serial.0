Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A3CCA47B
	for <linux-serial@archiver.kernel.org>; Mon, 11 Jul 2022 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiGKMbm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiGKMbf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Jul 2022 08:31:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10053509C5
        for <linux-serial@vger.kernel.org>; Mon, 11 Jul 2022 05:31:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220711123128euoutp01efe4b9b1050a46f02d4a46a6d5a52122~Axkr1emyc1194011940euoutp01Z
        for <linux-serial@vger.kernel.org>; Mon, 11 Jul 2022 12:31:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220711123128euoutp01efe4b9b1050a46f02d4a46a6d5a52122~Axkr1emyc1194011940euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657542688;
        bh=KKDLw0t/ruT+zbHIgERBJ5RyHdphUugkfhRD7Gn6eF4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=hScXNpNlbxouL7GpS9n3TQDkTyNgKABrwoSvLZPmphhkxjaAoOMhobm9eJIgpLRMG
         SPMkudif7K7PPDcGrxQlkczuRGHHLTEtJKD2UDj22olvo8wgbWASsiOH8g/SAS08BO
         wB33xUS1psoozFTXjyhKlr8E5O6p0lX/137YLDOM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220711123127eucas1p121fd89fdf629c1d1067d7949b6f4f0ce~AxkrgQpaK1253412534eucas1p1e;
        Mon, 11 Jul 2022 12:31:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 02.AE.10067.F181CC26; Mon, 11
        Jul 2022 13:31:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220711123127eucas1p2d80a83101476b22285ca619a95e6db50~AxkrD8JKW2733427334eucas1p2b;
        Mon, 11 Jul 2022 12:31:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220711123127eusmtrp17e12dbbd692e9578024070da4c6869a6~AxkrDDEKx2921929219eusmtrp1O;
        Mon, 11 Jul 2022 12:31:27 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-76-62cc181f8bdf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.12.09038.F181CC26; Mon, 11
        Jul 2022 13:31:27 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220711123126eusmtip1fa4f2d31f968c49d9a73acff158c2347~AxkqXkVRm2923329233eusmtip1O;
        Mon, 11 Jul 2022 12:31:26 +0000 (GMT)
Message-ID: <4fb8c922-08aa-2ee3-8073-95b8a26bf5db@samsung.com>
Date:   Mon, 11 Jul 2022 14:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3] tty: serial: samsung_tty: loopback mode support
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220629004141.51484-1-chanho61.park@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7ryEmeSDBZc1rJ4MG8bm8Xl/doW
        zYvXs1l07uhhsdjRcITV4t1cGYu9r7eyW2x6fI3VYsb5fUwWZxb3slucvraA3eL8Nn8HHo/r
        6wI8Nq3qZPO4c20Pm8e8k4Ee++euYffYvKTeY/GynWwefVtWMXp83iQXwBnFZZOSmpNZllqk
        b5fAlXHm+SOWggNSFee+tbE1MG4S7WLk5JAQMJFYNeU1UxcjF4eQwApGifOdW5khnC+MEuta
        TzJCOJ8ZJY5+XcsE0zL97RSoluWMEtt2t0FVfWSUOLH2ASNIFa+AncT0g21gNouAqsSlqc+Y
        IOKCEidnPmEBsUUFkiXOnb3KBmILC7hLdM5oZQWxmQXEJW49mQ+2QURgGqNEx9wp7CAOs8AP
        Jokvu06BTWITMJToetsF1M3BwSlgL7HgjglEs7xE89bZYE9ICEzmlOi9uosN4m4XiddP5jBD
        2MISr45vYYewZSROT+5hAZkjIZAv8XeGMUS4QuLa6zVQ5dYSd879AlvFLKApsX6XPkTYUeJM
        zzpWiE4+iRtvBSEu4JOYtG06M0SYV6KjTQiiWk1i1vF1cDsPXrjEPIFRaRZSoMxC8vwsJL/M
        Qti7gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmBCO/3v+JcdjMtffdQ7xMjEwXiI
        UYKDWUmE98/ZU0lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4
        OKUamLLrTm7r9Pa8u7xQ42ZGmRjj8rvfHzvsM4w8uuyN8I3iH4cVns1ZtXPTkpSe1n6pP+fF
        ZIW4fyTnSRoq/mNKvVvcIr9eX3B/arnURY6OjdbVJ6QXGrhP71sqz75i1eGm3dkLttS3mt/W
        7Jm2I3aa9clfzpoHmnQ4ru/mUC65+i76nZn/U1uNzCtq62L/2lfG81zkrUtn7vn2ZPH6g2fe
        Vtny1lZsdNOtW6XD9Gr2hr728NCdM6y6HzcwFbt8OD1XsO1B2C7uCEHr6Z/+Hvfg7E0ycJuj
        Lb5h2SUzNdOXupVvFm5uk9m+WkJ6Ctvia2cnXUy6Pz0p3WmlsGONyAGd3J6tlTWR/5SerepY
        qeR6RYmlOCPRUIu5qDgRALMFf8jXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7ryEmeSDE5/4bF4MG8bm8Xl/doW
        zYvXs1l07uhhsdjRcITV4t1cGYu9r7eyW2x6fI3VYsb5fUwWZxb3slucvraA3eL8Nn8HHo/r
        6wI8Nq3qZPO4c20Pm8e8k4Ee++euYffYvKTeY/GynWwefVtWMXp83iQXwBmlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Hm+SOWggNSFee+tbE1
        MG4S7WLk5JAQMJGY/nYKUxcjF4eQwFJGidXX2tghEjISJ6c1sELYwhJ/rnWxQRS9Z5TYM2Ey
        E0iCV8BOYvrBNkYQm0VAVeLS1GdQcUGJkzOfsIDYogLJEs1bDoHFhQXcJTpntIINZRYQl7j1
        ZD7YZhGBaYwS73Y1M0EkfjBJ9G7RgNg2iVFi16N2sA1sAoYSXW9BzuDg4BSwl1hwxwSi3kyi
        a2sXI4QtL9G8dTbzBEahWUjumIVk3ywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yf
        u4kRGMXbjv3csoNx5auPeocYmTgYDzFKcDArifD+OXsqSYg3JbGyKrUoP76oNCe1+BCjKTAw
        JjJLiSbnA9NIXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD0yZN
        N/7+nqQbb9fZn/o8uUlySuS9nIKmOL1aybOXjp//8y/03+3QSjmmx4UZF78nplw4vFbmUP2D
        wM2VD/q0dbfnlZwO5Lr19WJ4Tkt0z4rpt9nka1uc65c/VDo117VfPsRj6zaFmYvfbuBwPBM9
        /7jjEX3bGP6obgfeoDSFVAMvi2VOvbOXittXx4v+5i2e/nUh292rJuUTHrp9ExE8yOX7UVT/
        kTZLyB/p6u2HdroqJM6//2yFsIi27YaZ7wW0OGvlX+ws1bQzst/Hmzc/kecc4xqe2fouU7YJ
        b7C+8K7jRvKuOTeMfOatU7K1/3siMG2uQsV+qfdNjHM2rP4uoZu1+tMK1aXCXe48i1TclViK
        MxINtZiLihMBWIzcFWsDAAA=
X-CMS-MailID: 20220711123127eucas1p2d80a83101476b22285ca619a95e6db50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
References: <CGME20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc@epcas2p4.samsung.com>
        <20220629004141.51484-1-chanho61.park@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chanho,

On 29.06.2022 02:41, Chanho Park wrote:
> Internal loopback mode can be supported by setting
> UCON register's Loopback Mode bit. The mode & bit can be supported
> since s3c2410 and later SoCs. The prefix of LOOPBACK / BIT(5) naming
> should be also changed to S3C2410_ in order to avoid confusion.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
> Changes from v2:
> - Add Ilop and Krzysztof's R-B tags
> - Drop linux-serial-test related commit messages
> - Wrap commit messages at 72 columns
>
> Changes from v1:
> - Drop TIOCM_LOOP return from s3c24xx_serial_get_mctrl as pointed out
>    by Ilpo. Documentation/driver-api/serial/driver.rst indicates the
>    bit is only for set_mctrl.
> - Change the loopback bit definition from S3C2443_UCON_LOOPBACK to
>    S3C2410_UCON_LOOPBACK because it has been supported since s3c2410.
> - Remove the unnecessary footnote and put a blank line before
>    Signed-off-by
>
>   drivers/tty/serial/samsung_tty.c | 8 ++++++++
>   include/linux/serial_s3c.h       | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d5ca904def34..03ef4ff506fd 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1012,6 +1012,7 @@ static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
>   static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
>   {
>   	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
> +	unsigned int ucon = rd_reg(port, S3C2410_UCON);
>   
>   	if (mctrl & TIOCM_RTS)
>   		umcon |= S3C2410_UMCOM_RTS_LOW;
> @@ -1019,6 +1020,13 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
>   		umcon &= ~S3C2410_UMCOM_RTS_LOW;
>   
>   	wr_regl(port, S3C2410_UMCON, umcon);
> +
> +	if (mctrl & TIOCM_LOOP)
> +		ucon |= S3C2410_UCON_LOOPBACK;
> +	else
> +		ucon &= ~S3C2410_UCON_LOOPBACK;
> +
> +	wr_regl(port, S3C2410_UCON, ucon);

S3C2410_UCON must be modified at least under the local_irq_save() or port lock, otherwise it breaks kernel console operation on older Exynos SoCs (especially when DMA mode is used).

The above read-modify-write sequence should be replaced with the following pattern:

         if (mctrl & TIOCM_LOOP)
                 s3c24xx_set_bit(port, S3C2410_UCON_LOOPBACK, S3C2410_UCON);
         else
                 s3c24xx_clear_bit(port, S3C2410_UCON_LOOPBACK, S3C2410_UCON);


>   }
>   
>   static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index dec15f5b3dec..1672cf0810ef 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> @@ -83,7 +83,7 @@
>   #define S3C2410_UCON_RXIRQMODE	  (1<<0)
>   #define S3C2410_UCON_RXFIFO_TOI	  (1<<7)
>   #define S3C2443_UCON_RXERR_IRQEN  (1<<6)
> -#define S3C2443_UCON_LOOPBACK	  (1<<5)
> +#define S3C2410_UCON_LOOPBACK	  (1<<5)
>   
>   #define S3C2410_UCON_DEFAULT	  (S3C2410_UCON_TXILEVEL  | \
>   				   S3C2410_UCON_RXILEVEL  | \

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

