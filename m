Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209D2FAC08
	for <linux-serial@vger.kernel.org>; Tue, 26 Aug 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199900; cv=none; b=ShYKIjBoL92sakReIaV7zu7hPvbkkOX+jkMpuf335mPSItZtMATTpoouxmJweFMHly9iprpvaXaWJX/l3/rOHhdzTnuuBKu20IsN1lSVHC7/7kzj94jwZRydsRc3l4+V5IYc0svNwwwQ1xifO+SdUmS6qFFALgvrMdrnaaOUYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199900; c=relaxed/simple;
	bh=TkwVE2JtukWSJCieI0x/e2MinM15H3GeZu1WuQJWONE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aHdkWTBjNkWBEUp4OQTcqv3FeUlnZL9RwCmK8yhFbtjyLMVmbjtA4h8ibiG3aO9VjYww/KBZlQZa1aA3YD1p44L1nUragXJHJ0w3vaauaoV9SkJsIhrHsVCOHUylPeaUkpqMoOW8492FkwNs5tEpAAIPANsIE4pM1H/hc+dT0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKFu5IyX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKFu5IyX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso27413195e9.3
        for <linux-serial@vger.kernel.org>; Tue, 26 Aug 2025 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756199896; x=1756804696; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y82ZcMTvoPNY3nU1FX8UKDNck7AnFMwEFoUX52rQcM=;
        b=vKFu5IyXgmCUHoNdfRVzChw8Knkq9L4J9tGkkg4vAQ3EjWBrPuIsaXTy5djOTSowX/
         pLOXVqEojG0DVbPa2m7OG4IEw4zdhCGiFkA4OZ/iH2QrULXRgPLLKVjWqlJU5piIL9B5
         R81c9NU5bgUiEmxfssH1Es8iH7iTWmKD+gp1RzagC4cKj32g660GBA8ysTwG37X9Jltp
         pLf8vNhHKbwi+MkRpcJ15fXPXBnINJrTN4DI3B/KeempkcmGOatClOVYhNwwavvdcf/g
         7GCzUv2474392wlK5YaGS/5Dykg7cJNLPRFMw79InSbfvRjZTfsHjSEI7CanZXlHegxU
         RoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199896; x=1756804696;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9y82ZcMTvoPNY3nU1FX8UKDNck7AnFMwEFoUX52rQcM=;
        b=RG6ifoz9V+qdtASXxzrOBggF3F3KMSJpmMByEhmxjqLym4g1YaLLWn3mpEx/QyJjVl
         5sC17nBNLZ9nHYZjmqR/prfDJQgwb60MxrwlLf8TkcEYhyZoxexyqEYtT6RF+pGxg25D
         SJ/I+4LnH7Dyb1YHzUmSP5cePehXaYYsVSXd/dovAc66nY34HVcXa/NTL33LJyaL1jeD
         8iN7/l0UFooFUDW/nok463S706r8R/mx88nW42+KLaKX5zo6WEQbPloVr/Yp2gaghPSi
         pG2C1j8lhTztWcXGa9SG4weBBVqAfhYBjujVrN+B0iOfz18oonOkGR7RDLrHHoT/p2Mb
         4Uig==
X-Forwarded-Encrypted: i=1; AJvYcCWiqeIYEjaiN5abmiZhntnHpzh61aGU6KpnvVYYCjK6eMDT/7/w2GiRWz4xnUY1zF0rG9YPjN9VoUMJtss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJ5/hUMU0AyXfdo5Oruahu4YLP/teNvCFh1wYq5zDO0sxhF6Y
	JnNaLJBfH6Uo4IIqYbngtMkwTzID2LCwd5Ja0zgPvthSOUlj4gDru6ynrDWKA0DErCk=
X-Gm-Gg: ASbGncs8FtbgiDkgiBkEsvrGfJAxFoUKJ3Cqb+/kB3mEQvgx0TXAdIgDuC9qCXj5vyU
	iOEymlFcZQShXI4D2CImnFN/jHKdBkIdvMpzsHTgQm6DeLAHDBzZFXuhdTR6IAxdebQZ0nCfD8B
	DKoZzDrO4RuxwCjeXHIFYnKOkV4iCnv7Us+ZOGst8t5QEzDy/mQpEGA8ciqXNz4WW3J60PoI51M
	7G13aQmpO0OAN96NTmX6Zq27IvCR3dNwlX73L4XzHVLVxPihot9qAdZ9qTH9rX+0sI9IQG0i3oD
	9/jU8ONxNcqKe9wjRkvSYPcD9FdYrkeL/3zhd3V4H2i9MlOLPSU3b3+Ka+wA94cE/T4Wy7Xj7nr
	uA2LUwHVva9WbtFbl4/S5OY9Kup8=
X-Google-Smtp-Source: AGHT+IHaeN71tfpJgG6c+hKwU5zaiIqic2SJiq3pkNi5jCxctYL6arGbSvZYy9jIMTOStKjZ+u5h9g==
X-Received: by 2002:a05:600c:a09:b0:459:dfde:332e with SMTP id 5b1f17b1804b1-45b517c2ea6mr85576555e9.29.1756199896087;
        Tue, 26 Aug 2025 02:18:16 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:e633:2c7e:2d3c:f5ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5748798fsm141608355e9.13.2025.08.26.02.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 10:18:13 +0100
Message-Id: <DCC8WLEKNS8W.9GAJHQGYPZIY@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <dmitry.baryshkov@oss.qualcomm.com>, <psodagud@quicinc.com>,
 <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
 <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
 <quic_cchiluve@quicinc.com>, <quic_shazhuss@quicinc.com>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <bryan.odonoghue@linaro.org>,
 <neil.armstrong@linaro.org>, <srini@kernel.org>
Subject: Re: [PATCH v7 7/8] serial: qcom-geni: Enable PM runtime for serial
 driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Praveen Talari" <quic_ptalari@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-serial@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20250721174532.14022-1-quic_ptalari@quicinc.com>
 <20250721174532.14022-8-quic_ptalari@quicinc.com>
 <DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org>
 <577d05d4-789b-4556-a2d2-d0ad15b2c213@quicinc.com>
 <dcad137d-8ac9-4a0b-9b64-de799536fd32@kernel.org>
In-Reply-To: <dcad137d-8ac9-4a0b-9b64-de799536fd32@kernel.org>

Hi Praveen,

Hi Praveen,

On Tue Aug 19, 2025 at 8:16 AM BST, Krzysztof Kozlowski wrote:
> On 19/08/2025 08:50, Praveen Talari wrote:
>> Hi Alexey.
>>=20
>> Thank you for your patience,

Well, any update on this?



>> On 8/12/2025 3:35 PM, Alexey Klimov wrote:
>>> (c/c Neil and Srini)
>>>
>>> On Mon Jul 21, 2025 at 6:45 PM BST, Praveen Talari wrote:
>>>> The GENI serial driver currently handles power resource management
>>>> through calls to the statically defined geni_serial_resources_on() and
>>>> geni_serial_resources_off() functions. This approach reduces modularit=
y
>>>> and limits support for platforms with diverse power management
>>>> mechanisms, including resource managed by firmware.
>>>>
>>>> Improve modularity and enable better integration with platform-specifi=
c
>>>> power management, introduce support for runtime PM. Use
>>>> pm_runtime_resume_and_get() and pm_runtime_put_sync() within the
>>>> qcom_geni_serial_pm() callback to control resource power state
>>>> transitions based on UART power state changes.
>>>>
>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>>>
>>>
>>> This breaks at least RB1 (QRB2210), maybe others.
>>> Currently broken on -master and on linux-next.
>>>
>>> Upon login prompt random parts of kernel seems to be off/failed and
>>> debugging led to udev being stuck:
>>>
>>> [   85.369834] INFO: task kworker/u16:0:12 blocked for more than 42 sec=
onds.
>>> [   85.376699]       Not tainted 6.17.0-rc1-00004-g53e760d89498 #9
>>> [   85.382660] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>>> [   85.390547] task:kworker/u16:0   state:D stack:0     pid:12    tgid:=
12    ppid:2      task_flags:0x4208060 flags:0x00000010
>>> [   85.401748] Workqueue: async async_run_entry_fn
>>> [   85.406349] Call trace:
>>> [   85.408828]  __switch_to+0xe8/0x1a0 (T)
>>> [   85.412724]  __schedule+0x290/0x7c0
>>> [   85.416275]  schedule+0x34/0x118
>>> [   85.419554]  rpm_resume+0x14c/0x66c
>>> [   85.423111]  rpm_resume+0x2a4/0x66c
>>> [   85.426647]  rpm_resume+0x2a4/0x66c
>>> [   85.430188]  rpm_resume+0x2a4/0x66c
>>> [   85.433722]  __pm_runtime_resume+0x50/0x9c
>>> [   85.437869]  __driver_probe_device+0x58/0x120
>>> [   85.442287]  driver_probe_device+0x3c/0x154
>>> [   85.446523]  __driver_attach_async_helper+0x4c/0xc0
>>> [   85.451446]  async_run_entry_fn+0x34/0xe0
>>> [   85.455504]  process_one_work+0x148/0x290
>>> [   85.459565]  worker_thread+0x2c4/0x3e0
>>> [   85.463368]  kthread+0x118/0x1c0
>>> [   85.466651]  ret_from_fork+0x10/0x20
>>> [   85.470337] INFO: task irq/92-4a8c000.:71 blocked for more than 42 s=
econds.
>>> [   85.477351]       Not tainted 6.17.0-rc1-00004-g53e760d89498 #9
>>> [   85.483323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>>> [   85.491195] task:irq/92-4a8c000. state:D stack:0     pid:71    tgid:=
71    ppid:2      task_flags:0x208040 flags:0x00000010
>>> [   85.502290] Call trace:
>>> [   85.504786]  __switch_to+0xe8/0x1a0 (T)
>>> [   85.508687]  __schedule+0x290/0x7c0
>>> [   85.512231]  schedule+0x34/0x118
>>> [   85.515504]  __synchronize_irq+0x60/0xa0
>>> [   85.519483]  disable_irq+0x3c/0x4c
>>> [   85.522929]  msm_pinmux_set_mux+0x3a8/0x44c
>>> [   85.527167]  pinmux_enable_setting+0x1c4/0x28c
>>> [   85.531665]  pinctrl_commit_state+0xa0/0x260
>>> [   85.535989]  pinctrl_pm_select_default_state+0x4c/0xa0
>>> [   85.541182]  geni_se_resources_on+0xd0/0x15c
>>> [   85.545522]  geni_serial_resource_state+0x8c/0xbc
>>> [   85.550282]  qcom_geni_serial_runtime_resume+0x24/0x3c
>>> [   85.555470]  pm_generic_runtime_resume+0x2c/0x44
>>> [   85.560139]  __rpm_callback+0x48/0x1e0
>>> [   85.563949]  rpm_callback+0x74/0x80
>>> [   85.567494]  rpm_resume+0x39c/0x66c
>>> [   85.571040]  __pm_runtime_resume+0x50/0x9c
>>> [   85.575193]  handle_threaded_wake_irq+0x30/0x80
>>> [   85.579771]  irq_thread_fn+0x2c/0xb0
>>> [   85.583443]  irq_thread+0x16c/0x278
>>> [   85.587003]  kthread+0x118/0x1c0
>>> [   85.590283]  ret_from_fork+0x10/0x20
>>> [   85.593943] INFO: task (udev-worker):228 blocked for more than 42 se=
conds.
>>> [   85.600873]       Not tainted 6.17.0-rc1-00004-g53e760d89498 #9
>>> [   85.606846] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>>> [   85.614717] task:(udev-worker)   state:D stack:0     pid:228   tgid:=
228   ppid:222    task_flags:0x400140 flags:0x00000818
>>> [   85.625823] Call trace:
>>> [   85.628316]  __switch_to+0xe8/0x1a0 (T)
>>> [   85.632217]  __schedule+0x290/0x7c0
>>> [   85.635765]  schedule+0x34/0x118
>>> [   85.639044]  async_synchronize_cookie_domain.part.0+0x50/0xa4
>>> [   85.644854]  async_synchronize_full+0x78/0xa0
>>> [   85.649270]  do_init_module+0x190/0x23c
>>> [   85.653154]  load_module+0x1708/0x1ca0
>>> [   85.656952]  init_module_from_file+0x74/0xa0
>>> [   85.661273]  __arm64_sys_finit_module+0x130/0x2f8
>>> [   85.666023]  invoke_syscall+0x48/0x104
>>> [   85.669842]  el0_svc_common.constprop.0+0xc0/0xe0
>>> [   85.674604]  do_el0_svc+0x1c/0x28
>>> [   85.677973]  el0_svc+0x2c/0x84
>>> [   85.681078]  el0t_64_sync_handler+0xa0/0xe4
>>> [   85.685316]  el0t_64_sync+0x198/0x19c
>>> [   85.689032] INFO: task (udev-worker):229 blocked for more than 42 se=
conds.
>>>
>>>
>>> Usually wifi, all remoteprocs and anything that depends on lpass/pinctr=
l fail to probe.
>>=20
>> May i know what is testcase which you are running on target?
>
> Boot the board?
>
>> what is target?
>
> It is written in original report. Did you even read it?
>
>> Which usecase is this issue occurring in?
>
> Boot?

FWIW, what said above by Krzysztof is correct, there is no usecase, just bo=
oting the board.

Best regards,
Alexey

