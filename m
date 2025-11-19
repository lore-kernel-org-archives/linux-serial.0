Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C45363C41
	for <linux-serial@vger.kernel.org>; Wed, 19 Nov 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558899; cv=none; b=Jq54md2ISp5dvDr4BvpX3piX2tQQwkwiTh5YskSHdnZDPXq45uVYVwhQTuPqQm0erJDCjjMnWtMpNvR2ETFL3A5Gc5a6edPmOfJkTN33wtK6Da3PTrmCT5b1XP11hqTJ2mm9evWR3fhTxYGb7y3/IeCQguVadha6AP7wLKQIRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558899; c=relaxed/simple;
	bh=gHpwjjREhsAd8WKsVYT8IYp6+ZQIN7Tnm8WoUEA8aZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnF1XV6j/WxrOKA3C+4qJukR+D+dfIKB0rO7/wb+b1IDlc5yrfgB5QFihLIiOMom4JyVWzpk6zSloIRQSRP2eOlsEDv/SvsWDQtVD0TKb18WyucpsnPD6c5A81v1tUk/0nsgYVE/zMTI7xkWjCIvl1QpfdAWMVN324Su5OErROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZB0fy+cS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZB0fy+cS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59445ee9738so5235726e87.3
        for <linux-serial@vger.kernel.org>; Wed, 19 Nov 2025 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763558893; x=1764163693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Fz2SH1ZUm7FuuivONGxxUgBBznVGQP+s2/x19XhOc=;
        b=ZB0fy+cS1xYK9vha6Tv00U0twgMJFjTq4+9aYZ8hfvmNMqly9QfDD0oXfZNzwWRpbh
         JwGFoamRilDGXXJFFu9byVUjYTEGhBvrAkUaTW4zbHsxMiaCmJXWKWGGJ1wn+TY/2Aog
         twpOHdet9yu8ZPQAozLB0jDV4ur4E5xF7GGdhCc+mwzbml3XhLsLF/WkE3y/uHdyVfNy
         WSixf7XnPG58jugGaEQVpZRATC1hb9sAaUkNE1pRhY9SE4CtrJIfLMbXjMgDs4Jd1T0s
         TnaJUFkbVzs4/Wx5SLGTYQ+q9yG5OJixmqZG+sza1llI6xYIr6g9l8B5eKkFJLn7A4Bg
         BWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558893; x=1764163693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9Fz2SH1ZUm7FuuivONGxxUgBBznVGQP+s2/x19XhOc=;
        b=EGzTQwAjjc3i7J9SJh9Kt8qOgs4J3lA5lzp5xMkCtLUb7o0UL4t4n8ZbasMzPzQW9z
         1t6zNNNsIW45dRrzE2ANZInISGWu27TnReSTFHOmelDZzv8iKpWQCcUydM82gyxMVFgB
         8b1eIkYUO1Rj3QWoQhKTSc5o2bD2xxX1NTridFcsKjC3YI8LvQzBmuWe05uIXhFoZukO
         yuKsm+soe+r86FANVOS2rG+2xhGNJV6S4B8TjS5jeKnzJ8tfsKTuxDpK9haoeLs8MgE6
         3y7AjcBFY3WX9XAL8gTlHURuFVU2YTmDAMdayycRccr13BanUU+Kqg1FS9kdno/15Nrm
         doag==
X-Forwarded-Encrypted: i=1; AJvYcCVJu2xKVcTeZ2NhbOP8YYGL159mIs7gdS2hq80TbbG53fVBHPgmreIdmeUshZEY+zG4VF9AUoEzZpN9/WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsbqvKzsQfAZ43+1EJ/+jKJhe89vFyMqyIV6vZi+KGv5NEVyq
	CJxG8DvArLVsG9tahLCIfZ5ONjbQKtMAoS61BgnerRvqMeNAz2o25EBuXdarngo7imtoZGBoVVn
	LrMSNm+JQ8/mGH2erg37WoNiV2+o5Uw0PmqRHz5tIiA==
X-Gm-Gg: ASbGnct0JwFqW88nfTKbdEsY9Qm7vz45Ag0oGeVagKU0oVv13UWOfp7eF+ji2DMarpD
	DbobmlKyLrplc/6Ug6YEyeyFKGzgjW2InFGBmWoXz8BaAEOsPXHWfAnaeLCGhusRVld30g8wy+P
	l32yCTxtxxLq7ARPk02LkF0Zg1XBdl8+2zfSPUTVhrjUdroz6Nf+a+GcDOewQ0Itgw1HKhXD99x
	FK/bCgdsrmbbiPGI8yJ6tdJm3Txa6DqO9wChN9Qr+XcHjNwJE5U/yNYBfPC9f8a+uQ0Dg0YymAm
	oN28b2DH8NogHyoWe1MjK5mftb5XoD2VMNck9d6/Mj7AYNk4
X-Google-Smtp-Source: AGHT+IGJBnlU8SfCgN2H396Pf5rcfKBaHkLraBwus+9No1IWypEaF8w8j8PGxkXY9nu4VlhBBrtuUvloX+iTMlSUET4=
X-Received: by 2002:a05:6512:1326:b0:594:2cdf:1941 with SMTP id
 2adb3069b0e04-59604e3f4e4mr1143048e87.31.1763558892975; Wed, 19 Nov 2025
 05:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-9-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-9-97413d6bf824@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 14:28:00 +0100
X-Gm-Features: AWmQ_bm5iCKbfw8hpw1YVmAcjxIFk-iHf3DCtBX1MsQ5hHQ1VM87jgrdbOpF5Hc
Message-ID: <CAMRc=MeyeyuNVP6CWcxNp8XSCT+P9ZNmgSj6Hktrv8ZYNN5kMg@mail.gmail.com>
Subject: Re: [PATCH 9/9] power: sequencing: pcie-m2: Add support for PCIe M.2
 Key E connectors
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:45=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add support for handling the power sequence of the PCIe M.2 Key E
> connectors. These connectors are used to attach the Wireless Connectivity
> devices to the host machine including combinations of WiFi, BT, NFC using
> interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.
>
> Currently, this driver supports only the PCIe interface for WiFi and UART
> interface for BT. The driver also only supports driving the 3.3v/1.8v pow=
er
> supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
> connectors are not currently supported.
>
> For supporting Bluetooth over the non-discoverable UART interface, the
> driver currently creates the serdev interface after enumerating the PCIe
> interface. This is mandatory since the device ID is only known after the
> PCIe enumeration and the ID is used for creating the serdev device.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>
> +static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);

Since this is new code and gpiod_set_value_cansleep() now returns an
integer, can you do

  return gpiod_set_value_cansleep()?

Same elsewhere.

>
> +static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned lon=
g action,
> +                             void *data)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D container_of(nb, struct pwrseq=
_pcie_m2_ctx, nb);
> +       struct pci_dev *pdev =3D to_pci_dev(data);
> +       struct device_node *remote;
> +       struct serdev_controller *serdev_ctrl;
> +       struct serdev_device *serdev;
> +       struct device *dev =3D ctx->dev;
> +       int ret;
> +
> +       /*
> +        * Check whether the PCI device is associated with this M.2 conne=
ctor or
> +        * not, by comparing the OF node of the PCI device parent and the=
 Port 0
> +        * (PCIe) remote node parent OF node.
> +        */
> +       remote =3D of_graph_get_remote_node(dev_of_node(ctx->dev), 0, -1)=
;
> +       if (!remote || (remote !=3D pdev->dev.parent->of_node)) {
> +               of_node_put(remote);

You could really use some __free(device_node) here. It would simplify
the code below quite a bit and make sure you don't miss anything.

> +               return NOTIFY_DONE;
> +       }
> +       of_node_put(remote);
> +
> +       switch (action) {
> +       case BUS_NOTIFY_ADD_DEVICE:
> +               /* Create serdev device for WCN7850 */
> +               if (pdev->vendor =3D=3D PCI_VENDOR_ID_QCOM && pdev->devic=
e =3D=3D 0x1107) {
> +                       remote =3D of_graph_get_remote_node(dev_of_node(c=
tx->dev), 1, -1);
> +                       if (!remote) {
> +                               of_node_put(remote);
> +                               return NOTIFY_DONE;
> +                       }
> +
> +                       serdev_ctrl =3D of_find_serdev_controller_by_node=
(remote);
> +                       of_node_put(remote);
> +                       if (!serdev_ctrl)
> +                               return NOTIFY_DONE;
> +
> +                       serdev =3D serdev_device_alloc(serdev_ctrl);
> +                       if (!serdev)
> +                               return NOTIFY_DONE;
> +
> +                       ret =3D serdev_device_add(serdev, "WCN7850");
> +                       if (ret) {
> +                               dev_err(dev, "Failed to add serdev for WC=
N7850: %d\n", ret);
> +                               serdev_device_put(serdev);
> +                               return NOTIFY_DONE;
> +                       }
> +               }
> +               break;
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port=
, const char *node)
> +{
> +       struct device_node *remote;

Same here.

> +
> +       remote =3D of_graph_get_remote_node(dev_of_node(dev), port, -1);
> +       if (remote && of_node_name_eq(remote, node)) {
> +               of_node_put(remote);
> +               return true;
> +       }
> +
> +       of_node_put(remote);
> +
> +       return false;
> +}
> +
> +/*
> + * If the connector exposes a non-discoverable bus like UART, the respec=
tive
> + * protocol device needs to be created manually with the help of the not=
ifier
> + * of the discoverable bus like PCIe.
> + */

I really like this idea BTW!

> +static void pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *=
ctx, struct device *dev)
> +{
> +       int ret;
> +
> +       /*
> +        * Register a PCI notifier for Key E connector that has PCIe as P=
ort 0
> +        * interface and Serial as Port 1 interface.
> +        */
> +       if (pwrseq_pcie_m2_check_remote_node(dev, 1, "serial")) {
> +               if (pwrseq_pcie_m2_check_remote_node(dev, 0, "pcie")) {
> +                       ctx->dev =3D dev;
> +                       ctx->nb.notifier_call =3D pwrseq_m2_pcie_notify;
> +                       ret =3D (bus_register_notifier(&pci_bus_type, &ct=
x->nb));
> +                       if (ret) {
> +                               dev_err_probe(dev, ret, "Failed to regist=
er notifier for serdev\n");

If this is optional and we don't handle the error, should we really
print it as one? I'd say a dev_dbg() would suffice unless the failure
here impacts the driver's behavior (which it does, so maybe the
notifier should not be optional?).

Bart
