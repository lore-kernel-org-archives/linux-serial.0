Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19421CC4F
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766308319; cv=none; b=g1sTrcN88kfnHRpS9Z3DUkn9gEPTTSnoqtE2g4MehFI0WnSQqgAvu9o/UeFeQ7mMSiCzQXKsqf0eAGx4XV+JrTkMo5fs3UVF6pnGNY5qcUqDCvZ+xngZVzIQe4sZ/X//nfjztc2QnlLlfP+GenHTv8XhKRPZ3J9jkwygoOVCXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766308319; c=relaxed/simple;
	bh=p4K6ZZ5UDbv6xtedRbkKqqzY+uDr3R/k1JkTcnv+oro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRQq49bplB9A+jQz8lzInf9sGhf1Prwog35MG90hNr5KtOQ3DybHXZ/ZRatDPL0ymJOEQvowp7dqNa3yj1cRexkzW9AqpCYobINarlTiojSIXjS5B4MGUaNipOhjJiaHLsaPdrZb8hE/ncrs4F94aWpdEqw10T7RM6ImsuL5Jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6D1rLmk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6D1rLmk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f98adea4so457708466b.0
        for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 01:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766308316; x=1766913116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJxTo1StsAPyAw5V2VT3FLs+d6cjUn62zSVYT6JS2So=;
        b=N6D1rLmk3gP51ACwD0tA1zW27UOIXVfe4Elg8MJkX2SwEKtjMUQkEt4H44vKWfBN3+
         UuzKSSgyne5VGI0uqg82gJajSi/ckpvSznIc5IjQ+QCzCTNu99DS5S0kadt0X5ixbiDO
         lV8O2Ev5ss3qVIWEAx3J5HedVWbNK/JH2cqXbk3WPlP4vUAx0gd+NWIB1mggy1g4K8JA
         BG4DPBx8kdaqc/6sdcDOQfH4rH6x78N1Cz3OQdV4tP7FuNill8diV7DyKhuOdPPcAmdi
         8JTyT2ph38kgqzE7NT58UmBDEEbctbg1VfqDa2ans/QKw4X6uA4qQD2Hhqvwn2WQE62k
         t2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766308316; x=1766913116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJxTo1StsAPyAw5V2VT3FLs+d6cjUn62zSVYT6JS2So=;
        b=tfuGbBYBTgB/d7kVCDbjRT8KD6uo4IbXeU88KA+8MNCy8tq88YpzlGAuTw5tQrwknV
         OubDCdefnNTKPwLsSLBbApg7hfOdIBl6TosU/l4Gun1/zmHuKCKTcZTuwV+jQmMetHph
         pSc5LpzP6QoQ/tmGfAc8U30n+8sYrbcvdk/ZcGfn+ipDX5ScbW+NUNxEWw4yYEqHlbmY
         hY/631SGT4iTdQV0mvCU9G5YXL1OR8UdMcPxEKECsQ62iKFdf1QBM5lGd+qDWFYelCBN
         oe5VPdoZTwsLk/SRiMw34MF69E1bm1+euzpG0zc863vwzwvBKBMu1PZf4Ftf0gz92Z3S
         MN5Q==
X-Gm-Message-State: AOJu0YwviOzpCJqSNlVy7e29YtrXmPuhujFVbcvuHQR3gdNLcaoGAzUO
	VEamdLBWjb9TcXGUIe+XmqGvJ+Hjradk5dhTnDNcXZsSiK2yWXYt6zMg
X-Gm-Gg: AY/fxX5mSfD9pSo3xs+wredPydKbrqwkTh8TC3ez4NWMH/e6YpglbT4tkW1XztfbFrf
	8qM43vKRhTh4+YMJowuRs5CMMZMuTVRCnjn8eR8Wq1yoO4XIPp5xR7Wc+vw+R0Cm84jApu6Nx67
	flTQ3H+PNDUVMsZZUgXAaF7mNM4WmjVgdWERp5fgOWkHOwTcP6W02Xz3LTEMiDyEWpiW9N67Nke
	DfS+8O+B5TC87jb3xpnOTTmEviaCTRLPhWhk36XSZmIYomVoKms6iGu1oKwdyNA6i2OyhGsVE0C
	mfA9Wl1PVV/s6CMlB3LMPE9b6K4AmJLBVeXUGNAE0lmfkYtMulifi/TqbNR5AHL7tNOtmQJ26vu
	ogu+IB7fEAsh+h+P+f7iVzwiTB7Z/95Ff4BHjYBqVjkDI6RbRb8XpxE7UcYXApihkJNB0UhWUSp
	iHNzLll7hRnREojnOXRChY6+CJ407WmXF9KE1L9fWOuoFOi19bbTpJSHeCnvkO2WYKcq475GQid
	aBnu3x2plkiA9ib2R04VgkZxLV0p/tnF2ZuuiesKFhuVw==
X-Google-Smtp-Source: AGHT+IEsEr93QO0hH1tZL57OTUeoBwpBNF/UhF1GdR8z9V2lP4dhUOAFVvNvMgPMaCLAYn6SQxRbOA==
X-Received: by 2002:a17:907:3fa8:b0:b76:3548:cdef with SMTP id a640c23a62f3a-b8036f2abcbmr808495166b.25.1766308315612;
        Sun, 21 Dec 2025 01:11:55 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:9f8f:28b1:4136:8493? (p200300dfbf2de3009f8f28b141368493.dip0.t-ipconnect.de. [2003:df:bf2d:e300:9f8f:28b1:4136:8493])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f37ee8sm704325366b.59.2025.12.21.01.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 01:11:55 -0800 (PST)
Message-ID: <c65689bf-67fd-4f7e-a878-59675ad429c4@gmail.com>
Date: Sun, 21 Dec 2025 10:11:53 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] samples: rust: add Rust serial device bus sample
 device driver
To: Markus Probst <markus.probst@posteo.de>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Kari Argillander <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-3-e44645767621@posteo.de>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20251220-rust_serdev-v1-3-e44645767621@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Markus,

On 20.12.25 19:44, Markus Probst wrote:
> Add a sample Rust serial device bus device driver illustrating the usage
> of the platform bus abstractions.
> 
> This drivers probes through either a match of device / driver name or a
> match within the OF ID table.
> ---
>  samples/rust/Kconfig               |  10 +++
>  samples/rust/Makefile              |   1 +
>  samples/rust/rust_driver_serdev.rs | 175 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
...
> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_serdev.rs
> new file mode 100644
> index 000000000000..f23b38a26c32
> --- /dev/null
> +++ b/samples/rust/rust_driver_serdev.rs
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust Serial device bus device driver sample.
> +
> +use kernel::{
> +    acpi,
> +    device::{
> +        self,
> +        property::{
> +            FwNodeReferenceArgs,
> +            NArgs, //
> +        },
> +        Bound,
> +        Core, //
> +    },
> +    of,
> +    prelude::*,
> +    serdev,
> +    str::CString,
> +    sync::aref::ARef, //
> +};
> +
> +struct SampleDriver {
> +    sdev: ARef<serdev::Device>,
> +}
> +
> +struct Info(u32);
> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <SampleDriver as serdev::Driver>::IdInfo,
> +    [(of::DeviceId::new(c"test,rust_driver_serdev"), Info(42))]

I stopped reading here regarding the new "rust_driver_serdev" but
re-reading Rob's

https://lore.kernel.org/rust-for-linux/20241022234712.GB1848992-robh@kernel.org/

adding "test,<whatever>" should be fine as-is without any documenation.

> +);
> +
> +kernel::acpi_device_table!(
> +    ACPI_TABLE,
> +    MODULE_ACPI_TABLE,
> +    <SampleDriver as serdev::Driver>::IdInfo,
> +    [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
> +);
> +
> +#[vtable]
> +impl serdev::Driver for SampleDriver {
> +    type IdInfo = Info;
> +    type InitialData = ();
> +    type LateProbeData = ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
> +
> +    fn probe(sdev: &serdev::Device, info: Option<&Self::IdInfo>) -> impl PinInit<Self, Error> {
> +        let dev = sdev.as_ref();
> +
> +        dev_dbg!(dev, "Probe Rust Serial device bus device driver sample.\n");
> +
> +        if let Some(info) = info {
> +            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
> +        }

Last time I had a look to the log output from rust_driver_platform.rs
(where this is copied from?) I was slightly confused to see the
"Probed with ..." in the log but not the "Probe Rust ...". Well, I
hadn't DEBUG enabled. So I wonder if the combination of `dev_dbg!()`
and `dev_info!()` this way should be improved? At least in
rust_driver_platform.rs because we could drop that here completely? I
mean in rust_driver_platform.rs it makes sense to demonstrate how
`info` is supposed to work. But do we need that here?


> +        if dev.fwnode().is_some_and(|node| node.is_of_node()) {
> +            Self::properties_parse(dev)?;
> +        }


This is a left over from copy & paste? I mean having all this
`properties_parse()` below and calling it here does not make any sense
here? And should be dropped completely?


> +
> +        Ok(Self { sdev: sdev.into() })
> +    }
> +
> +    fn configure(
> +        sdev: &serdev::Device<Core>,
> +        _this: Pin<&Self>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> Result {
> +        dev_dbg!(
> +            sdev.as_ref(),
> +            "Configure Rust Serial device bus device driver sample.\n"
> +        );
> +
> +        sdev.set_baudrate(115200);
> +        sdev.set_flow_control(false);
> +        sdev.set_parity(serdev::Parity::None)?;
> +        Ok(())
> +    }
> +
> +    fn late_probe(
> +        sdev: &serdev::Device<Bound>,
> +        _this: Pin<&Self>,
> +        _initial_data: Self::InitialData,
> +    ) -> impl PinInit<Self::LateProbeData, Error> {
> +        dev_dbg!(
> +            sdev.as_ref(),
> +            "Late Probe Rust Serial device bus device driver sample.\n"
> +        );
> +        Ok(())
> +    }
> +
> +    fn receive(
> +        sdev: &serdev::Device<Bound>,
> +        _this: Pin<&Self>,
> +        _late_probe_this: Pin<&Self::LateProbeData>,
> +        data: &[u8],
> +    ) -> usize {
> +        let _ = sdev.write_all(data, serdev::Timeout::MaxScheduleTimeout);


Is it intended to have a function with the name `receive()`calling
`write()`?

> +        data.len()
> +    }
> +}
> +
> +impl SampleDriver {
> +    fn properties_parse(dev: &device::Device) -> Result {


As mentioned above I think this is a left over from copy & paste and
should be dropped?

Cheers,

Dirk
