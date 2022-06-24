Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02900C43334
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jun 2022 17:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiFXRD1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXRD0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jun 2022 13:03:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5137A06
        for <linux-serial@vger.kernel.org>; Fri, 24 Jun 2022 10:03:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o9so4301624edt.12
        for <linux-serial@vger.kernel.org>; Fri, 24 Jun 2022 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s5nDVvgWy+RryiS6/QVVgyQjkiH7gGyVNqw60wo0/GY=;
        b=Hhj3cNudPsVKi2Ye5EHXAic9I+DK/940ySoUKVqZcIaogTDDPgCyM0UUx5Etdbl3KV
         d/KNUegEiDShpeLs8eTZsBT1fPyCOGvJvl6aMViiurIIB9sqCoXzyHeu0j93EXH1DQy0
         ZPVoaM1Yyr2j5EFf5LpF8fDrwegcnBJE0t0Ex5JLogo1zkXed8EnDf0OFsxCkGe2f59A
         BqwvQWokfslcVH16hu2sunziqMunyi8x+1cN/tLck5/P8oRPqLH8rrd6hmdfSYwlkmS2
         loYLWdp+/430NcJtKr9AMk414NhO4UW82aHFWURKSouBQU2rX9dGCS1L9HV1URqqLI1/
         734A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=s5nDVvgWy+RryiS6/QVVgyQjkiH7gGyVNqw60wo0/GY=;
        b=u6DGl238kILxxKQDK6VfGAeLf2W1WA5VjZW4uFv9gePkb9nCi8zoSVEKWf/1nMG2Ss
         ngQ/FYeLfi0VB3ACIKFJSB7fiRaxlCH7I0e/N9slr7Oo8Xcxq084Wz5x1Vz0xdi3PuMm
         nlUsjYYS+Fa/STzD3l0YzIOCDd5j6MkB3Bul0sDoNxoX2yh/ANwQx2BrQ6VHz5Bd2h/4
         hfVE9DiI8NueMMNh8kObhjHNKzfIBb19wyg4ppWyu858fwe+1PLIVzb9U1vIiq0FPFvx
         n7nFZ+Y4UB5ZmJtgSB1UiMaDFFCL8WY1eP8uxfIEGXJNQtriUSAO9D7U7DDJYOo1d4k0
         Ap9Q==
X-Gm-Message-State: AJIora+oV0avgTn+ob/1259XqAAMJ6cammf3VARniRATo+bRaXs96tWM
        Tlg5l1rZiRT3qt+Lvs2zYfDyUC1p9xVVsS8KyY5Mha727DM=
X-Google-Smtp-Source: AGRyM1vh0qRT+pe405UtXgYrEUsbH/SHnRIGUFVmed1+dGqzBMhAzQ9NFLATdIIFUXbXYCEd4e71hTSB1TavlAPWcmY=
X-Received: by 2002:aa7:dac2:0:b0:435:76a2:4ebe with SMTP id
 x2-20020aa7dac2000000b0043576a24ebemr71964eds.196.1656090203894; Fri, 24 Jun
 2022 10:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAAcv5+4C6YekJmVzWqDnbp3O7MJ-Pny4MUp7uvqWzrbCweixTQ@mail.gmail.com>
In-Reply-To: <CAAcv5+4C6YekJmVzWqDnbp3O7MJ-Pny4MUp7uvqWzrbCweixTQ@mail.gmail.com>
From:   Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>
Date:   Fri, 24 Jun 2022 18:03:12 +0100
Message-ID: <CAAcv5+4msJnQawknnjaBWG9fNhmhr9CPcLOzZxgQ7A36SGG=Dg@mail.gmail.com>
Subject: Re: Sending gnss data during suspend doesn't work
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For information I solved suspend/resume issue by adding following code:

ret =3D pm_runtime_get_sync(&serdev->dev);
if (ret < 0) {
pm_runtime_put_noidle(&serdev->dev);
goto err_serdev_close;
}

But I think the hardcoded prepare issue is still valid.

Best regards,
Mohamed Ali

Le ven. 24 juin 2022 =C3=A0 09:28, Mohamed Ali Fodha
<fodha.mohamed.ali@gmail.com> a =C3=A9crit :
>
> Hello,
>
> I am not able to send data (serdev_device_write(gserial->serdev,
> standby_cmd, strlen(standby_cmd), MAX_SCHEDULE_TIMEOUT)) to gnss in
> suspend callback (from sta8089_set_power):
>
> static const struct gnss_serial_ops sta8089_gserial_ops =3D {
> .set_power =3D sta8089_set_power,
> };
>
> but it works during prepare. To do this I have to patch the following API=
:
>
> @@ -21,10 +21,11 @@ struct gnss_serial {
>   enum gnss_serial_pm_state {
>   GNSS_SERIAL_OFF,
>   GNSS_SERIAL_ACTIVE,
>   GNSS_SERIAL_STANDBY,
> + GNSS_SERIAL_PREPARE,
>  };
>
>  static int gnss_serial_prepare(struct device *dev)
>  {
> - if (pm_runtime_suspended(dev))
> - return 1;
> + struct gnss_serial *gserial =3D dev_get_drvdata(dev);
>
> - return 0;
> + return gnss_serial_set_power(gserial, GNSS_SERIAL_PREPARE);
>  }
>
> Is it normal that sending data during suspend doesn't work?
> I think there should be a solution to use prepare without patching
> gnss_serial_prepare.
> Any ideas please?
>
> Best regards,
> Mohamed Ali
