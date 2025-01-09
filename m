Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6C217F2D;
	Thu,  9 Jan 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426477; cv=none; b=jcD82gjtdwJ7VwEHoUOU924aluT9TBhVWRXz7aY4jDT8YeC59o6mKPfstW9oH7yMbg2+WV+/7d9INLV3snr0DREhCMvXTk0iywnZ1mc2RPZrJXQwiTbJ9guIK0HBAKFvQ55tvJ0bZpuSE9X1oUqKhg0PdJFBAnyVw1w4BNNpeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426477; c=relaxed/simple;
	bh=XDETphudTkO5SR/6iJFvKW/m3QJJKDgjjrim8xrq0SM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JRiNzr4HKDKZjPW0pR7b9YEacBpigbjJf+uUTu59M7O1cuTjo3SymSiz7K23LBPZe9759+sTJyDsbVFJSUs3CNOutFLUGbkDQujkFGhkwY29x8koHVRsQNJGNRMrinAlUQ7QW98WGIqaWoki2M9fAff9dcZKebytVMp/cZYNYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AqIYGNzM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TLkq2b5z; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AqIYGNzM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TLkq2b5z"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E1D0E1140137;
	Thu,  9 Jan 2025 07:41:13 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jan 2025 07:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736426473;
	 x=1736512873; bh=wLJ++Q6SQnW5cldO099ySb/sSi0K9kC5oVRX+QgY0b0=; b=
	AqIYGNzM+3ZEQiz6trTJ8M8C1x1B2w45qggfgDKhYKItKVqknlXd5azWExek6RQ1
	41VXFOJJzHdKPNfQ10su3cYcmp9/naB97ItUrPDJH/ib0KmzxbOFNauLB53NhhaI
	mDheU7cGsNSZUrbuFFbYQ6+WCU/r9zM5OnWmYQ8yCt167Gk4Q3/sRgpNOzxpDvJT
	3bn3ijqON38+rH0eDxCYH1N91Jof44SGo0HfNIWCaP+wPT3zFftgnDOT8dJXl2pi
	G7c4nkL78n+TeRVDyYwTkP0M9Uxn8SWLfzuf2SCw5p6Pshv+CpCPk796gz72OdXk
	CK4WfLG4xOA8HfNYvGrRrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736426473; x=
	1736512873; bh=wLJ++Q6SQnW5cldO099ySb/sSi0K9kC5oVRX+QgY0b0=; b=T
	Lkq2b5z1wrjG5ZqruI2Pn48zH3CaDfab8sRtUzXEx92GPLCS9DOP6CZViiAxdOpe
	YXaCFL6ZQM49TmZ+0DEs7JYIT9b4S3AgwuvA5bvJo3KM8lzuXZ06bIxb8erdW40Y
	O5QVoBPiPjORRKPzDZFFjZZJ4DU9YMgLE6NVTb3x6Hky4wuzPp5pYxBESrqU9nJY
	5tTGUZR8Vv07ZjS3KtpcWEBUKydiWYmHSgGC5FTUnh/sTq1yx9s5V5nHWCVaQyLF
	L6kEmvdkBDS5gHArsdN6PxLdQQmEi7L+VBCmohUhqpzgwi4tYMaowWAqU4GrXpPB
	s7tpOeyWeO5okupkV61jw==
X-ME-Sender: <xms:6MN_Z0fzcymtyfeLmArHr58a9F4qoTvUgyQQl5wqFRwz5w7W2ke5Cg>
    <xme:6MN_Z2N7WvI9xTYxsV6ylkkf9t9NELKt2CphDbKhyOVKAmGteVowXvBVGsEzCUG0T
    lttcoqWlQlMb1MOJpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpnhgvfihmrghnsegtohhnnhgvtg
    htthgvtghhrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    hulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhi
    nhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkh
    hosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghhvghnghhuohifvghise
    hunhhiohhnthgvtghhrdgtohhmpdhrtghpthhtohepghhurghnfigvnhhtrghosehunhhi
    ohhnthgvtghhrdgtohhm
X-ME-Proxy: <xmx:6MN_Z1jTBQwX_FjYAmqM5bndWqDkJrV526ZV2XxYki2Nl1Kzl_H-Mg>
    <xmx:6MN_Z594X8Qp0mGheBVbr0yxCPGdCVbF_LwV-256CbEh8qoj5m26iw>
    <xmx:6MN_Zwv63LNrjo-o5Uv7_u4hvj6CkLeLtnzEy7nngNBoWpnqOfsHuQ>
    <xmx:6MN_ZwH1xqpvRS-ofGtsAjjnEctrlQJFwnGx7YYAbQLuM8z7ApazJA>
    <xmx:6cN_ZwFh175Jy_NXdKaXST6i7U2sFhA3j-hHMzp2gv60F4fIv2dGYAc8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48A7B2220072; Thu,  9 Jan 2025 07:41:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Jan 2025 13:40:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: WangYuli <wangyuli@uniontech.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, pnewman@connecttech.com,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, zhanjun@uniontech.com,
 guanwentao@uniontech.com, "Zhuozhen He" <hezhuozhen@uniontech.com>,
 "Guowei Chen" <chenguowei@uniontech.com>
Message-Id: <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
In-Reply-To: 
 <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
Subject: Re: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250 driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025, at 13:08, WangYuli wrote:
> [ General description per its product manual: ]
>   The IT8768E-I is a highly integrated Super I/O using the Low Pin
>   Count Interface. The device=E2=80=99s LPC interface complies with In=
tel
>   "LPC Interface Specification Rev. 1.1=E2=80=9D. The IT8768E-I is ACP=
I &
>   LANDesk compliant.
>
>   Integrated in the IT8768E-I are five logical devices, which can
>   be individually enabled or disabled via software configuration
>   registers, and four 16C550standard compatible enhanced UARTs
>   perofrmacing asynchronous communication. The devices also provide
>   GPIO port controlling up to 12 GPIO pins.
>
>   The IT8768E-I utilizes power-saving circuitry to reduce power
>   consumption, and once a logical device is disabled, the inputs
>   are inhibited with the clock disabled and the outputs are
>   tri-stated. The device requires a single 24/48 MHz clock input
>   and operates with +3.3V power supply. The IT8768E-I is available
>   in 48-pin LQFP.
>
> It has been determined that this chip is currently employed within
> YIHUA STS-320 intelligent teller terminals utilizing
> PCBA F21-2401 D2000 MB VerA LF motherboards.

Can you explain why this isn't done as part of
drivers/tty/serial/8250/8250_pnp.c?

I see nothing unusual in here that requires a custom driver.

      Arnd
