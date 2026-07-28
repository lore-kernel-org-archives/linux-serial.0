Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E593A3815
	for <linux-serial@vger.kernel.org>; Tue, 28 Jul 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249905; cv=none; b=rQ6di4YK9EDkm1t22lO6WRl3Ea0oAoWAwe4bqbZpwNPCkevgFeydlB1beuI9dgaw00SfefMo2GMkfzGN3TNPNeFcgA8B1FJ5JM1h2WxXz6wvfXI+In5DxPqnJPAo3IHXPU4elyjKjgvz9z0kpNK3gc/LSlFeaSmtfs5MYGZch+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249905; c=relaxed/simple;
	bh=DiG15UEixbfgu6yBzjjk0nE3N6X6W7RUMAOuyWSj2Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r4gSGYT10xmsqighnXYj4RI8wciyQs93R9D+wCVlst9E9f1ya32UAW1AKsBWfG0kuwUOHNaSnt5L3yNWyW/CLDUY7atvs8RQOfckjj8SCnsM9w4gfP0r59SO6JETdvWIis3feuMhA+rTyYvvdPyMEx+jkm0Phcj10oQgukomo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pn+UJd9r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BLjKZ80t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pn+UJd9r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLjKZ80t"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEcqwa3239004
	for <linux-serial@vger.kernel.org>; Tue, 28 Jul 2026 14:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1DldpSgzdWMuNocSYgYiD1
	ND93sFzGYAHc+0uoq3k7g=; b=Pn+UJd9r9zneS1hR/bYg4qYyajMAZTRqJYcBn6
	ePeA7RD5/E/j3Tq39jhC027ZEVVi+iMSHRSfmB3QuT+JpQ+0atlNVNHHLbYg/yzm
	u2HGO2LCSvP109p8mE87V2iFddEIPO4WTOA7R/NysIIB0f5gOAP69+TYTVYJmLe7
	anUbEHowZPW7+67pNEuK1PQErytUQtdQmBUPyccLy1Gw885ugjC89x+3Qn94TGPQ
	dHWvuZZRoFqCMDUHMeDc7WahHyQYbcuYA2i5oyqcgfRyQH96v0rz9AJUDnCW/6nI
	dvyAiPLkMp7dFKBMtq5wYVbgcpU7uT2yi1ubzoi2AtNA8LjA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7kdfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 28 Jul 2026 14:45:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ec3314f65fso50338576d6.3
        for <linux-serial@vger.kernel.org>; Tue, 28 Jul 2026 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785249902; x=1785854702; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1DldpSgzdWMuNocSYgYiD1ND93sFzGYAHc+0uoq3k7g=;
        b=BLjKZ80tLxm7cuD10F+NxaLuJqdrxwzMR+0KaBKRq1j3s3l1k+mEP8nWvURHf4bfZJ
         kmnTHRpI4C86PDgTulxAoGPk7evP+em13UZ5XZzPFnSdN+VVccVcs4//BSR1/Py3k5Sr
         Z90vemNe2TfT65XFmx87U0zmwWWMGAxH8/avhU6Kr6KsxAuspUsOumw36a2X9Ik/hJ2s
         IH12pgJjqYb2AasgpT2jrRCU+fXHFHY8NrWfzn5GYmnTIDcT+MIsBffBh6E50uRtjknV
         mmx2Idoge3L07DemEFGsoKZnKlIPFXvkH89lrrGZCxWbTMRiXn8YZKwF/IVrT533ycTt
         vh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249902; x=1785854702;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1DldpSgzdWMuNocSYgYiD1ND93sFzGYAHc+0uoq3k7g=;
        b=FHY0mTZLunp5EIrnyLbD7Cs/MOdx/BRawjG0fmMPZOBKq9HUJPT4TZCPQdyNrmRsmc
         DiaD9cOpqW2ahvaa0W9e17jbEH+fNTsZaIjLlYnflLMvS94d1QQa1Oq07YuN9o5cTDrR
         s3Sef7aATZusoAZq1OGOfzeAIzXoPAOkaPoVNm5DXbUzzbybrpw1tObn4h8jAxmNDd6L
         lmm0g61vK7qrC78Qxnq8DtMtm/8AIaqt/Mfcz7eVGq3VS9ePUlSHS9DNlsAN8vce+wOx
         SKuvf/ljhWnN1ZJwUGR8ztTxQhB/6nANOQqx1CC01RqJQYFp3fr60U6Ko07U7h8rSeLo
         3orQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPRRg2XvWSgWnGN9Sh92qTT7cdEkv2mB1qOptDQ3hY8D0v1NUUkp5CrGABmL5oVF753fMD1vyJbr73bMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zrfFmCSjUFth7ifOVv16cYY4q+rUkOPxJdAkmHJ07Be5dlxH
	G7Ew9zJRiq6QKcf22bO8OJZjy9mZdYpNRc0BiW1A+qIBicdktPxAVKXcHVYceD5aUB9KEYBge51
	RDw7N100tewPjj3TYQvzq4muvw1CtYtc5cAeEeBi+whP+ti6p3LZ8ribNJbZpVE6ek58=
X-Gm-Gg: AR+sD13i2GXx7fkLtR3xvGp9/Dt7s1odpgLCVMjH34rMX3iHuorUfBwS1FQJoUD4ZkB
	2m/h45uURbeoPe18gOqrcNZt+pn9AbvUauCCW4sflZSldhKc//vf5DCMgqreOy/SB7olfKyez3g
	aZ/I+0XSK0z8h4ZUCtlq5jalAe0yzjsSg+nmE+zL3oPxdO9qHW3qj6OcWCHszPTqYANhOwWtEjn
	RaQ2dikYf00snqW2S+y8FxsOhrVq2JmIYl+3uxtH/psZp96bVSki7xuhYlRC12Tc0X8JzC8qW2x
	BEzBt5DyMhjEV08Num19dirqZXvQgWWlqBtwNkwGqxbOiIFRcZHcJivP0jEdFJGNZHwt60+XKwv
	vbpVe9DbGSjXRkAWO+OyFPvX/n0MtvQ==
X-Received: by 2002:a05:622a:1b10:b0:51c:1ff:2515 with SMTP id d75a77b69052e-529d7135d23mr22659231cf.65.1785249901794;
        Tue, 28 Jul 2026 07:45:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1b10:b0:51c:1ff:2515 with SMTP id d75a77b69052e-529d7135d23mr22658831cf.65.1785249901373;
        Tue, 28 Jul 2026 07:45:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d2e3:b407:476e:c977])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm65584869f8f.24.2026.07.28.07.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:45:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:44:50 +0200
Subject: [PATCH] serial: 8250_exar: use platform_device_register_full()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-exar-pdev-reg-full-v1-1-7a96e77309e1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGHAaGoC/x3MwQpAQBRG4VfRXbvFmJBXkcXgH24J3YnU5N1Nl
 t/inEgBKgjUZZEUtwQ59oQyz2ha3b6AZU4mU5i6aEzLeJzyOeNmxcL+2jZGVTpjbTPasaIUngo
 vzz/th/f9AFVhKOhkAAAA
X-Change-ID: 20260728-exar-pdev-reg-full-e31a2447b4b3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DiG15UEixbfgu6yBzjjk0nE3N6X6W7RUMAOuyWSj2Ng=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqaMBn45X/Mc0VWgtR3wbfgsNJVvEu6vrk38sAZ
 YiA40PAIS6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCamjAZwAKCRAFnS7L/zaE
 w1slEACv3midsVoK4ZPfI8voL/xBvPxN+/6q6VdUJps96ta7rEc9Nkoy9d4imUYoKkNei2kY0yL
 tOdWZ0jmp/Zx6FjL2R1j1KhGyZJQLLIMS8I3YfbnTSu+Yflt+FyXTGPuEhlFwOSnm0W1wawiFME
 ryiAre8EcZno0gNjUajNx2rLddrjGeV8DkKip8XvygyVTo6OA8lfTxoc9JPd1ZxaKlJI/NgKHLX
 5eGP+7wYmnhhvSwMiARLHoICl18wHwiogH6qpgCfOFlKJL+3XJUdBOFac2YqxxVy54OmniSL8Tz
 VusVvC4FE/uCuU0lg0Mo/JepOg+wBRLd/kJQuQb5suFCE/nxJIxpKgZNKqyXKzOGSAMyhvQJPtb
 Z+47y4TfBPZ2f/ZFq0tqs7gMgIvBGjVAeEYhTqLgOfV2F1Mm3eo/M7HZNarm9X72gknb6AhZI1v
 CUIsUizsF1w0OLRRhtG0ZhPEUVQObx6IQeSbEDkupWGP1nvIxcjxiNHkGg+TEhAcVIRgT5bLkJE
 yfaCSFGhjxJV8xuUe9UNErMouSJhDEE7Qr9wt1eW95hN4rhI5+byOCmYg/z+sDYyA96bmiwY7Bq
 xYqHw7SuHGoUK2+frpbzcUcZMbOW9xdTHLzEXWi4wnMyYV3StgnNBDI219bbijcC4ufAWm0hasR
 d7Y6MCBNNVA5zoQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzMSBTYWx0ZWRfX0u0Ltu0lEuhl
 8gXjouB2xyrvQCE7NMpFEhvAp8YFotwByA90EIlRdYbA+p1d3Up6TLJq1PAnUVSmwVJD/LtJCBX
 rEUzu3mj9KA+1FJ4sLJ40RdiGzQexmu2QCYIQbt93fmmeD4NOYori1rnV48UkV/lSUxQ3R0xNRe
 u8pQezTWrriQGwJDjpPGaAsavtgpImat1jni1ngJyUI15Qi2vt06cIdAIbhC5h/pwDOOgM0b93G
 VfWFmcMDoU6vxs48+lcYtHJSbnkh5wGza9lc1IvZlSbKZORzHfFwdxZnMuxArRVYYhcZxlcViU7
 LcRsW5iDICXdk3MbVatHkh/Z8ovsBeDgdzYCd83+OX7ZDqCUYVBCUTQgyMXgQhImDQOXHw+hKKp
 Aq8JQnRwpxMzhPHPorEQAJwmWcKMCMX8kz97D+4U3/4w5bUnC34SIyyvUy/0Vnycz9V6agI1Z7W
 NKfBH2kgtsPfV851dLw==
X-Proofpoint-ORIG-GUID: UBeE4rwKC4E0rjHRy2v5Eg9kC8AwQuDE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzMSBTYWx0ZWRfX28K222Oklt6u
 5t+L9IRU7NSjBTw3P/KHVkU7faYb+Uv1lLmKlds/WqLBi7rm9sdGW6605evmDlqSllWUjemSLpz
 RZfeQDXjFIkON3e42+r0wP0v0GSRnps=
X-Proofpoint-GUID: UBeE4rwKC4E0rjHRy2v5Eg9kC8AwQuDE
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68c06e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=PZUIP3pysVZmXZS8_XoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280131

This driver doesn't really need to split the registration of the GPIO
chip into stages, as platform_device_info already provides fields for
the firmware node, parent device and the software node. Use
platform_device_register_full() and simplify the code. This also
addresses the problem with incorrect reference count of the assigned
firmware node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/tty/serial/8250/8250_exar.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index f9a14eaa13cba85f2424c351510be093f52fd6a1..836792e861bfc742a14de90640a6252dca1bd226 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1140,22 +1140,15 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 static struct platform_device *__xr17v35x_register_gpio(struct pci_dev *pcidev,
 							const struct software_node *node)
 {
-	struct platform_device *pdev;
-
-	pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
-	if (!pdev)
-		return NULL;
-
-	pdev->dev.parent = &pcidev->dev;
-	device_set_node(&pdev->dev, dev_fwnode(&pcidev->dev));
-
-	if (device_add_software_node(&pdev->dev, node) < 0 ||
-	    platform_device_add(pdev) < 0) {
-		platform_device_put(pdev);
-		return NULL;
-	}
-
-	return pdev;
+	struct platform_device_info pdevinfo = {
+		.name = "gpio_exar",
+		.id = PLATFORM_DEVID_AUTO,
+		.parent = &pcidev->dev,
+		.fwnode = dev_fwnode(&pcidev->dev),
+		.swnode = node,
+	};
+
+	return platform_device_register_full(&pdevinfo);
 }
 
 static void __xr17v35x_unregister_gpio(struct platform_device *pdev)

---
base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
change-id: 20260728-exar-pdev-reg-full-e31a2447b4b3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

