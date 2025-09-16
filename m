Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F12F5A01
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042767; cv=none; b=fryxNFofzPuXWr1rZUfnxr8aKtPMB6kb+hYFlzaXhLj1EoAr43ht28FyEeRX60b3Ad2dwhFL6DqxBZDOyRjWY1uGTEbzgyigNhLsCwVTDFrwdqqZehpACO6EN5Zk3MDZBUQq7ddmPLz8c5YhY8R/r9gwAZtM0lwJd53x1iNuZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042767; c=relaxed/simple;
	bh=Df+/LaMxpKWk0GPaLhm0ZV3PeANKFNnwG3l6SViBXok=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FYRHH3kpCae+zRvIttOhf+cMbn/+V3sOTmW0AX34mrdrt60qIaLwsn1POJTpZjnrQRePV+Oyzr3jjF5KBZxIiO2Qo4vvE45rmwQYEE5eslwIbootKN6tFvXYtIHDI1miqQqV6X5Knu5EG+C23WBbcs6TTJZ36PFLWeeIEGhaGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KBAt/bks; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBAt/bks"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so1872613f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758042763; x=1758647563; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqaF18q5/4RPXd/sNMBkEVcv6NngmKxTCLkka1/HN3A=;
        b=KBAt/bksKE9Vtg4QSCj3YaQRNsLGZBaURip8+xCsDvXT+txeavqZMkA2U9d+YA0UCY
         K+yqy5VdWBX5N3iG+OrOm1ccRtBTUqV59l2t59R84xD1ZyovZaruNwKq9weGCsYzzcX0
         c+jYkwPOhTNV1N8593jPZlgy5zXRdye1iRe8zFbj2j1ddPVq4ju+JbLIX5q7boSGDxNj
         JuNYSveJh1X3bc4uMvR9Z56S54V2QcFU5v00jg/9e177RROQXwbIh3EVre3UbZCBVdU/
         OHs/12pIgzRsVeOGavBOflkUN/95i/sYooYzrFr1+BeXijXdlkSzR2TL4HWO2tnm8KgF
         prBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042763; x=1758647563;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LqaF18q5/4RPXd/sNMBkEVcv6NngmKxTCLkka1/HN3A=;
        b=tNieMuAlTVodCnubU9+sN/03nfEy68JwmHlNf9RJkF+07MwiqkBhB8WQsWNnEnIFX/
         XpnWi4ct/qwWggs8VIgdhtuZYcliZtS2H8EJgGYkOz/028RmQlYVmKLYeU9exjiwTiLC
         oKGwyt+e9ImwqTQsllC3qT/qzzvB2UXK0J+07emyD8LJFCTDieZ/kmtdObHRLVhUozh1
         RH9aj81tPsJMwzT9qU28efkzzsgpd4p+/PgeJEnMkNS0slZNh6lCoV3Uzyn9e6U0TUzR
         K6+xBfbzoZMVRRkG+QCqsHBz6XTTUQzOA3TlbpWX55IxruwSZ+MCDONytBrFhRwseKZl
         KabA==
X-Forwarded-Encrypted: i=1; AJvYcCViCPSFKJIWyy5CckVFCzI+oOjyIW0OfyLZJ2DjjRVvnQ97Bvl2UISt0wBHvjzHGgjb9L/bIL1G6fHrRQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCi9+ehTYbcEkFME+SSKH+qIVYzmM/Hp2bC8dpdiEsXubFkC2
	COgHVL54qLWIXEQX853Hyu2x9n/CY5LYrhSW6nqSFDronTAb8j8VTl8n4Kyen3vpfj4=
X-Gm-Gg: ASbGncupMSEKqq+066ygpGUmgaabVMVPlTHHnRcAN7hzg666BJPln3q6KSR3sl2B9Sk
	HxP64ytxoniRfCEyX/RAdDWSJvu3OsNecL64oun4YUfUavAn3c/WoRijrPeiG5j1sF7OtIckKrU
	71PWoxfF6xNvacevNmStrUvpxAVd7kc1KZsbrSA53X7iNUE4bF2bxYcg3TWObgB9nHfDCiHiLm7
	SPPZ3BA74gtR3aW+kZTtMio3GoH65oDfBkf0jYr523gc5IHEsW7HyK+wgpQsVUplZ+v7fBhY22v
	G6UWeb/jK2qpcNU69Nw1ztikuRudEftE/ikbTwttjsUrKTZpq5uy0vdXW0UWf4mR47KEJAnj+7D
	fGy99rokOF0ttOwkOCOQ2X1lZcSIYnTLexklbSw==
X-Google-Smtp-Source: AGHT+IEvkFgtWL+kn+C4oAbEu7W8XPOmrkC2CA2oPkt3zTFfSB2E6147xEPwjsNR2v12L4eZwv8+xQ==
X-Received: by 2002:a05:6000:25c2:b0:3ec:1edb:97a9 with SMTP id ffacd0b85a97d-3ec1edb9a47mr4026382f8f.33.1758042762513;
        Tue, 16 Sep 2025 10:12:42 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:75ac:2ea2:dfdc:89c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd43csm22183897f8f.29.2025.09.16.10.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 10:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:12:41 +0100
Message-Id: <DCUE5AXJ99BG.150SRQMY7EJG6@linaro.org>
Cc: "Jorge Ramirez" <jorge.ramirez@oss.qualcomm.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Bryan
 O'Donoghue" <bryan.odonoghue@linaro.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
 <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
 <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
 <quic_shazhuss@quicinc.com>, <krzk@kernel.org>
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>, "Praveen Talari"
 <quic_ptalari@quicinc.com>
X-Mailer: aerc 0.20.0
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
 <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>
 <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
 <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
 <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
 <aMl2hOYTjBuCo4AM@trex> <aMl9Fbuyq7hdXvQC@trex>
In-Reply-To: <aMl9Fbuyq7hdXvQC@trex>

Hi Praveen,

On Tue Sep 16, 2025 at 4:07 PM BST, Jorge Ramirez wrote:
> On 16/09/25 16:39:00, Jorge Ramirez wrote:
>> On 16/09/25 12:20:25, Praveen Talari wrote:
>> > Hi Alexey
>> >=20
>> > Thank you for your support.
>> >=20
>> > On 9/15/2025 7:55 PM, Praveen Talari wrote:
>> > > Hi Alexey,
>> > >=20
>> > > On 9/15/2025 3:09 PM, Alexey Klimov wrote:
>> > > > (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not
>> > > > delivered)
>> > > >=20
>> > > > Hi Praveen,
>> > > >=20
>> > > > On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
>> > > > > Hi Alexey,
>> > > > >=20
>> > > > > Really appreciate you waiting!
>> > > > >=20
>> > > > > On 9/11/2025 2:30 PM, Alexey Klimov wrote:
>> > > > > > Hi Praveen,
>> > > > > >=20
>> > > > > > On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
>> > > > > > > Hi Alexy,
>> > > > > > >=20
>> > > > > > > Thank you for update.
>> > > > > > >=20
>> > > > > > > On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>> > > > > > > >=20
>> > > > > > > > (adding Krzysztof to c/c)
>> > > > > > > >=20
>> > > > > > > > On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>> > > > > > > > > On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>> > > > > > > > > > A deadlock is observed in the
>> > > > > > > > > > qcom_geni_serial driver during runtime
>> > > > > > > > > > resume. This occurs when the pinctrl
>> > > > > > > > > > subsystem reconfigures device pins
>> > > > > > > > > > via msm_pinmux_set_mux() while the serial device's int=
errupt is an
>> > > > > > > > > > active wakeup source. msm_pinmux_set_mux() calls disab=
le_irq() or
>> > > > > > > > > > __synchronize_irq(), conflicting with the active wakeu=
p state and
>> > > > > > > > > > causing the IRQ thread to enter an uninterruptible (D-=
state) sleep,
>> > > > > > > > > > leading to system instability.
>> > > > > > > > > >=20
>> > > > > > > > > > The critical call trace leading to the deadlock is:
>> > > > > > > > > >=20
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Call trace:
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __switch_to+0xe0/=
0x120
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __schedule+0x39c/=
0x978
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 schedule+0x5c/0xf=
8
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __synchronize_irq=
+0x88/0xb4
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq+0x3c/=
0x4c
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msm_pinmux_set_mu=
x+0x508/0x644
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinmux_enable_set=
ting+0x190/0x2dc
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl_commit_st=
ate+0x13c/0x208
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl_pm_select=
_default_state+0x4c/0xa4
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 geni_se_resources=
_on+0xe8/0x154
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcom_geni_serial_=
runtime_resume+0x4c/0x88
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_generic_runtim=
e_resume+0x2c/0x44
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __genpd_runtime_r=
esume+0x30/0x80
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 genpd_runtime_res=
ume+0x114/0x29c
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __rpm_callback+0x=
48/0x1d8
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpm_callback+0x6c=
/0x78
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpm_resume+0x530/=
0x750
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __pm_runtime_resu=
me+0x50/0x94
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle_threaded_w=
ake_irq+0x30/0x94
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_thread_fn+0x2=
c/xa8
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_thread+0x160/=
x248
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthread+0x110/x11=
4
>> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_from_fork+0x1=
0/x20
>> > > > > > > > > >=20
>> > > > > > > > > > To resolve this, explicitly manage the wakeup IRQ stat=
e within the
>> > > > > > > > > > runtime suspend/resume callbacks. In the
>> > > > > > > > > > runtime resume callback, call
>> > > > > > > > > > disable_irq_wake() before enabling resources. This pre=
emptively
>> > > > > > > > > > removes the "wakeup" capability from the IRQ, allowing=
 subsequent
>> > > > > > > > > > interrupt management calls to proceed
>> > > > > > > > > > without conflict. An error path
>> > > > > > > > > > re-enables the wakeup IRQ if resource enablement fails=
.
>> > > > > > > > > >=20
>> > > > > > > > > > Conversely, in runtime suspend, call
>> > > > > > > > > > enable_irq_wake() after resources
>> > > > > > > > > > are disabled. This ensures the interrupt is configured=
 as a wakeup
>> > > > > > > > > > source only once the device has fully
>> > > > > > > > > > entered its low-power state. An
>> > > > > > > > > > error path handles disabling the wakeup IRQ
>> > > > > > > > > > if the suspend operation
>> > > > > > > > > > fails.
>> > > > > > > > > >=20
>> > > > > > > > > > Fixes: 1afa70632c39 ("serial: qcom-geni:
>> > > > > > > > > > Enable PM runtime for serial driver")
>> > > > > > > > > > Signed-off-by: Praveen Talari <praveen.talari@oss.qual=
comm.com>
>> > > > > > > > >=20
>> > > > > > > > > You forgot:
>> > > > > > > > >=20
>> > > > > > > > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>> > > > > > > > >=20
>> > > > > > > > > Also, not sure where this change will go, via
>> > > > > > > > > Greg or Jiri, but ideally
>> > > > > > > > > this should be picked for current -rc cycle since regres=
sion is
>> > > > > > > > > introduced during latest merge window.
>> > > > > > > > >=20
>> > > > > > > > > I also would like to test it on qrb2210 rb1 where this r=
egression is
>> > > > > > > > > reproduciable.
>> >=20
>> > Since I don't have this board, could you kindly validate the new chang=
e and
>> > run a quick test on your end?
>> >=20
>> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c
>> > b/drivers/pinctrl/qcom/pinctrl-msm.c
>> > index 83eb075b6bfa..3d6601dc6fcc 100644
>> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> > @@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev
>> > *pctldev,
>> >          */
>> >         if (d && i !=3D gpio_func &&
>> >             !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
>> > -               disable_irq(irq);
>> > +               disable_irq_nosync(irq);
>> >=20
>> >         raw_spin_lock_irqsave(&pctrl->lock, flags);
>>=20
>>=20
>> sorry Praveen, didnt see this proposal. testing on my end as well.
>>=20
>
> just tested on my end and all modules load - deadlocked before this
> update so there is progress (now we can load the network driver)

Is it supposed to be orginal patch here plus disable_irq_nosync()?
Meaning changes for qcom_geni_serial_runtime_{suspend,resume}
+ disable_irq_nosync() in msm_pinmux_set_mux()?

It seems to work here but let me know few more runs.

Best regards,
Alexey



