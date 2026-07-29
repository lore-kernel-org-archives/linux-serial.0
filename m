Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818A33A9D1
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361511; cv=none; b=jzUFnvYlbRSW7zS7uNYZyHEFPNDb0bgAL03+ufpZ+i2/7AXGolZAT1dd7HOJEjbRHli+jdvPnjjVicmwDnK9YcHqZDCLXEcnfY9QmQ+nDQUIoAg/iJEMqmELyl6SFLj/ojGI3HgKH9L6pFihEDY1MRL+/x8SvghNB6IBUuz7Ozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361511; c=relaxed/simple;
	bh=8Gj1woh+YGfKoKUw8vUcFzinjyFOvJLPqGvaI9q49jE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W5g6Lanfr0Vcecjs2hlLHN3vG8/F1UijnmGcn+ZWyXUftsJlmU2HcKb09SxKBFNe2AtatBk5Jmo2r8xYopmpnqMQRCnytfI1fNQhx7lj+n/PPAraad9KZ9jkaI3XduU3yGqZWVdg2BABamXaaulfphjqwdH1RzHVxrLnYOpMfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWRovRpG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gw9yhUEk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWRovRpG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gw9yhUEk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TLXSG03477160
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 21:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MRNITidFnB6lZG6QW59LqI
	d5ZJlZIn1XEPqpGLYBxiY=; b=NWRovRpGx7l7MXPQuqz1NHxQaKVCGdOmxcA3LN
	9Pa8s/krGRF0s0qrGfRo4qYf4ir8sOF1X7G6f4RQ4JzX9T6dsbDl1Dk0bdae296k
	5/YjFC1BoLXkAqOwggL1YzkV2Huy2lISXvlIDKBjg3DjsIYP4Hfdb1OKVSTatUbS
	dajcDBJgUZyluOxt64DT3FhGr9EuamPPIz12tXXy67YWk+za0SvcK0KqAbivYkWt
	UHifpiYU9xBWCJaFySUo3vwl02kYeNYnlio+eYO8VtYA53nMjiWh8aiMsF0KiQ+B
	J2ZT1INrnVQZcMppo0Xsi3cgbwaRGRXGgNTm2oaBybRdVokQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqshs0111-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 21:44:59 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6aaf58e7003so682816eaf.0
        for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785361498; x=1785966298; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MRNITidFnB6lZG6QW59LqId5ZJlZIn1XEPqpGLYBxiY=;
        b=Gw9yhUEkuP8eoAmoZAs+cxEwrRX7r8anatHGrGrN/mVaksw58bz1pu8D50vCJdn9+F
         xpJGSKamYPsdFi2WlLxPrbnkfv8/lG/2fk+0fX9oXB3vRb1jiuK974+ck6p9fxNPQx30
         PyyfJTs97/dPy75NstiBeajupZ4Y80SnRXpMdEcOE+Lad9P5lLBIXePYG8Ta6lGhG+5U
         N0dSk/FiTJkUa8x1saUwQbTO2wjmTRuX3VBevsvjgDLvRJhx6txNAQJO8KZ92KzNHUWz
         YGpPRytcTS7hi3Zpx81ayNaxiZ0t8iGXqp2FYUT5f2caqZHwN8ODy/Ih6QPaZ/WDKQg+
         pHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361498; x=1785966298;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRNITidFnB6lZG6QW59LqId5ZJlZIn1XEPqpGLYBxiY=;
        b=mQLExr3fkoadeY4ZNzlxJPCnYug8sIBZCe0mpyA8E/uUo1l01cI33GoDbwtQMJW4kI
         puLN6CoyEvEn5p1m0Q/EmSkc0rQys0eL55jQ/9XFOAnk5sd6K3SbZ5lb+aRm6cJl+zt9
         SMRIS++VISmuwRVhlC0U0oBvOTe+M0p3iMESvbbpGImZ4qoSqaIo93dEpffmWIcgvZws
         Kr8i0i2mlkniM32UokkIv1bHNxzTeiHGnmPHfEzU+TyZh9S/Yni6FWbhgJuiHdJShOOF
         nUMdRaNEryQ8sEzU8am27+NlumoRvZjyF0o8soK47psmjpkwbCgP/SajGfhtN0m41/xn
         S1mg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7ji1W2YImbyjcmzAXnpZ6sdx0EVcl9qoEzg2tXU/y63Onjh33AeD/Eaqt3NnJXEf973EbXpCVE0gPUAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpgE41LLdR9DgnEssDrohayuuZBdr5dI8rOJwH+PuMrrwinb3
	D3WHD/vaMNEEi/4nZC/NjZMnXZjLCF1mwjJmQU+uYEepzahQMuhSUNGnA9XZPOxEPYiBsZj1j18
	Y3PgUYxHQ6LN5VTz5KrvuMzmFFv1XDUeW79EIm8VdLsb6byYthOXdL/dC3/VpAMHTpw0=
X-Gm-Gg: AR+sD11WUDbnt9iZXt8WsXhesHjfW7KKtsah1NrB+TqTHIkfU6GnxZZBi6lWctNsNYo
	MAA8/uyYvJAA6lovkHfC30czgi2Mg0P4KDH30aoHiboL7CuecCP7wxVPt6mfV77IbKYXim70Wws
	0EpBQ+MgxGTwozlS6/X865ZNTVH2AjauMeFK2k5NkgGPZ5MH/EfmwxIk5W3Fes4JnAGvLHFFu24
	xrovKzM8MTnJPOb+NaG3kYz3wzjHVMaNgI4p2FWc8SFCFUBHtk7GKLy4OW+pYM4EO+F6B8KwWEh
	XQuhyTVBDbIuMymRtC7GJK4PF+5cI1imt1QzV+y4NYKctJPZRHfx8Aqc+emzMYhHTbpAuE6aRb+
	/bgDaVGVhEJeO2zr/5X0=
X-Received: by 2002:a05:6820:16ab:b0:6a1:8c8c:abd7 with SMTP id 006d021491bc7-6acbbf1044cmr93483eaf.16.1785361497739;
        Wed, 29 Jul 2026 14:44:57 -0700 (PDT)
X-Received: by 2002:a05:6820:16ab:b0:6a1:8c8c:abd7 with SMTP id 006d021491bc7-6acbbf1044cmr93469eaf.16.1785361497286;
        Wed, 29 Jul 2026 14:44:57 -0700 (PDT)
Received: from [172.17.0.3] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c0df60fasm90790fac.13.2026.07.29.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:44:56 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH 0/2] serial: qcom-geni: Convert console to nbcon and handle
 RX overflow
Date: Wed, 29 Jul 2026 21:44:54 +0000
Message-Id: <20260729-qcom-geni-nbcon-v1-0-3053b96465ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZ0amoC/yXMQQqDMBBA0avIrB3QBG3wKuJCx6mdghNNbBHEu
 5va5Vv8f0DkIByhyQ4I/JUoXhPKPAN69ToxypgMpjB18TAWV/IzTqyCOpBXrCpX1r2zdnQEqVo
 CP2W/j233d/wMb6btt4HzvACkED1fcwAAAA==
X-Change-ID: 20260723-qcom-geni-nbcon-55816a833d8c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=8Gj1woh+YGfKoKUw8vUcFzinjyFOvJLPqGvaI9q49jE=;
 b=owEBfAKD/ZANAwAKAQsfOT8Nma3FAcsmYgBqanRX3aI6fYlRVF0RhQw/Ulag/FsLYkezbbdwl
 g/e05rAg7KJAkIEAAEKACwWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCamp0Vw4cYmpvcm5Aa3J5
 by5zZQAKCRALHzk/DZmtxcKbEACYmsa6A2BfakXT2Kr+YTebJ2C3v7QBgAyrJhzciZeFP6DS/8G
 JFE6AZZz4hkyp0n9yPa5NNBbXStNI8B8fRx0CQEw32Y0FUN+ScVmLV0LFgsaWKD3NBSs4kalfN8
 6t/YxUSMQkHP+TN4Hdek9ljvq6mAX4uV5gs3a9Yb6WOCpsqLOEkGkvWp75kPRqC/Eex4Zz/Tgey
 PbevkhBg8cNU2MSf1Bvddu2piC5Et0bWJOS3rO9+FbdRUAoH6k+gUaDRqblQfPAF27JZ5sCXWZM
 J8LZLSsYUdtcuJx1Ul4BiaewKkM3nm4bU6/1aG2lkhdOUzV8lLzNXsIBn7WIKpY9qtKOLBByFit
 vFsoDTj53j0AxYVye1iwIEABVhoEAHuyllxhnL0mLiDTY6586xvrWPF+fM4WBdkjVT6c4+UXf97
 ChFOj7OqJLpzcgMMpTNaGnzvFryZI2a0vQUC1CgAg0Sm9SgNsOXirwFTkufrFnHzczpWv53kjz3
 r7+ttNaub1NPcmow+62mkf00XTwva9Bwa/PQrgQJ77gvTBylash9pXPDAOSddtR2W2legppG4t9
 qOJS5I6MGxJVr/MYWbIX2wX8k0zbkhsSQxg2AyIowiLTDnkf/sVzyv4K9Pac8Sn76+NHqXAV1+N
 uSmzAEbL9m88JzvaP6zGpsdSnQOZSoSckPA==
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: 4cZ637PPjc4Sw_wsAqsSM0a6B5OGcnbk
X-Authority-Analysis: v=2.4 cv=D/l37PRj c=1 sm=1 tr=0 ts=6a6a745c cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ymw6HyzOBw0-piHZwAoA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: 4cZ637PPjc4Sw_wsAqsSM0a6B5OGcnbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE2NCBTYWx0ZWRfX4Ng+2cJd+iRg
 4TvLsRyKY6a+WE4UiUhEoX0nUuHHkYDDaH+dCLrycyqLXuEJkAPTtYTID7dp1RPzbLqorNoPXGv
 LmruiRl5yyTjlemTzKwnMhiPROAHjMDXdbgerTPUOejuhfAFeTX3LHF5Ly/f5Rjr7C9+IRP6GWE
 Xh71IxUJc8o7N7s3mBlDOVFnunpPKBzb/gBVR4L15tGA2rCTkortKlV/TW+0Uj7ngFiVo8zn+QS
 SzZanMVlBF9/Y4u9nx9y71C+oy5Vm6X3ryC7eeg+9hLp5Fj4jzvAiX7u6TpLh9CectCvBxpLtHH
 z5M8q7Fz3BI71yoihYz/sNoN3N2VeiSvBhRYSZzkD9/iLBek6quygomvX3ye6x2b0t9Mrlwlms/
 vus3LyYexl8W72FV8o4n2Ost4RW0ySJx0A6EdljXn+k/VzDr5e2Wba2Imbf3InSW78dUw+7zQ+D
 DCXwRwczCJmwaePzRdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE2NCBTYWx0ZWRfX+aByNx/YwOAH
 krfpQsyVAl5tQQIwp5/N+G+lJngUlgfnV/K0ptNlVDercoNtQMtEfh3XfMXNrgIF4FqO19AwKLJ
 8NTcKPs0w5s+ncehLjQxOFN7kdhb5pw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_08,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290164

The Qualcomm GENI UART uses independent sequencers. The main
sequencer handles console TX and the secondary sequencer handles
FIFO RX.

The legacy console writer disables both interrupt domains while it
performs a potentially long polled M-side transfer. Besides blocking
printk callers for UART wire time, this leaves the small S-side FIFO
unserviced and can lose interactive console input through FIFO overrun.

This two-patch series converts the console to nbcon, then keep FIFO RX
active while console output is in progress.

Patch 1 adds nbcon threaded and atomic writers. It uses bounded
32-byte M-side commands so higher-priority atomic output can take over
without waiting for a complete printk record. Atomic output may cancel
normal M-side TX. The driver restarts queued TTY output with irq_work,
honors flow control, and prevents deferred work from accessing a shut
down or removed port.

Patch 2 keeps FIFO RX on the secondary sequencer and drains it while
the threaded writer refills console TX. It also defers SysRq delivery
from this new receive context until the UART port lock is released.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Bjorn Andersson (2):
      serial: qcom-geni: Convert console to nbcon
      serial: qcom-geni: Keep FIFO RX active during console TX

 drivers/tty/serial/qcom_geni_serial.c | 272 ++++++++++++++++++++++++++--------
 1 file changed, 212 insertions(+), 60 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260723-qcom-geni-nbcon-55816a833d8c

Best regards,
--  
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

