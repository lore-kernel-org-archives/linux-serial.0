Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926368;
	b=sficr5Js2ldOzki2r8cZg5oyPUG8grZ/ilNT6/AlmdZB+WVMDQz0vIOv861vEDfzSdE4
	 8/wvPNTmTv8vYW6BaJrAjE4fK6KzMvtbMP96HN8gUQlRCsM41l4r2Hpr1cho4rWpOTKz6
	 IjkWSD7FSmayQjWnmosYKeYBU1YBSXtZQRsWXa0nu1BKluZLVJHfgrGEVg1UEjeNesP9O
	 PrqPhIdBSJdDG4ZplFCAW0/VioJ5u1/GY+w9wM6EDVt+BTtm+aRKHyjlp9oFYaUsWn78p
	 SbSNW4CwsWJnYr0qQU6I+TAh+I3Gq1gl5/HKZ6rjZXZgMAIyw/6PhLa57EbTonAMwXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926368;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=ZER2/wOCFh6jTs8o5A1q9yBCXNK7aYlQZn8jwh3/i8w=;
	b=nYAws6T5ckqWCAbK5vy8NttuIud24nEi+/s5D+O4RDnBU9pjA80J2iCpjAC5lWPbzdcW
	 ZtgzxWwJEDPHUU5FHeBUa3Je4Msb87HNDtKm5QlkE4o+sX7noIs4IZAGnHfKmhmKqQE+k
	 q58cnZ9rHx28tiFlFWa2BkhD2vuPskTac/9WTflhnfq1I3coHHp1GySRAIwJYpDz4iQ+R
	 VEg2zaxUnuLkNfSbPE1jpWDEmgeQdHExPmwewr0O4Fu63pfBtddu6BBJruILCMC+w1Xkk
	 uHvmN7NO0ptyEyxVMCChYPOVCAYrJjOPVCS40rkVQkUP6yTQBA9LPA7dA/38ej+GCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWI2BMWs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39553606A31C;
	Tue, 17 Nov 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWI2BMWs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8FD1F000C4;
	Tue, 17 Nov 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926367;
	bh=ZER2/wOCFh6jTs8o5A1q9yBCXNK7aYlQZn8jwh3/i8w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=nWI2BMWsttlpwtAmt4LaJy96tSaYvlKQ4qI3MRatdNxfTHjis8bUKTuUKieJsLPK7
	 ub6xwRAoLR+DWjbIqtZz147srqFgqCG52Glx2ANUUOPzeLJo2PwiqaaC/vsNui97+G
	 pdogDZEBB4F49ZPWS4t+H3zxz2aijkeJt06E7QyftMvYdYMH54gMbMkzLol4eDQyzm
	 IrgeYXK1vridWcyacxqJ5zWrQ3RfXlgxBVUcNZTGzaTi2c5gM+NXhMabZ0t/1sWpGJ
	 huJsjia2jT7UIHSITwbrvY0Hht6vMEIt3z9OZS5w+JwYk66RJcF77EZdz2JN1WlGND
	 X7EXIS+++wGBQ==
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 15:39:22 +0100
Message-Id: <DMXKAJKEIMFA.X1EWOKG0JRWG@kernel.org>
Subject: Re: [PATCH v3] rust: serdev: use Delta<Jiffy> for timeouts
Cc: <markus.probst@posteo.de>, <ojeda@kernel.org>, <a.hindborg@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <bjorn3_gh@protonmail.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <gary@garyguo.net>,
 <lossin@kernel.org>, <tamird@kernel.org>, <tmgross@umich.edu>,
 <work@onurozkan.dev>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <fujita.tomonori@gmail.com>
To: "FUJITA Tomonori" <tomo@flapping.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261103011143.917147-1-tomo@flapping.org>
 <20261117.200726.1503876918333666825.tomo@flapping.org>
In-Reply-To: <20261117.200726.1503876918333666825.tomo@flapping.org>

(Cc: Greg, Jiri)

On Tue Nov 17, 2026 at 12:07 PM CET, FUJITA Tomonori wrote:
> On Tue,  3 Nov 2026 10:11:43 +0900
> FUJITA Tomonori <tomo@flapping.org> wrote:
>
>> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>=20
>> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
>> which is a c_ulong alias. The type does not show the unit.
>>=20
>> Take the timeout as Delta<Jiffy> instead.
>>=20
>> The C side treats a timeout of 0 as "wait indefinitely". The Rust API
>> does not keep that meaning. A timeout of 0 or negative is rounded up
>> to one jiffy. A caller that wants to wait indefinitely passes
>> Delta::from_jiffies(isize::MAX). That value is MAX_SCHEDULE_TIMEOUT.
>> The C side replaces 0 with MAX_SCHEDULE_TIMEOUT before it waits, so
>> this gives the same wait as a timeout of 0 did before.
>>=20
>> Reviewed-by: Markus Probst <markus.probst@posteo.de>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Gentle ping.
>
> Danilo, could you take this through driver-core? It applies cleanly to
> driver-core-next.

I think serdev stuff usually goes through TTY.

Greg, can you please pick this up?

Thanks,
Danilo
