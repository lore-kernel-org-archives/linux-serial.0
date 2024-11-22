Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D440208A9
	for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319669; cv=none; b=KnJeFwrtrp/JBZVo94s1WOnjYW78eUaYyUim3K1bSRpyFoo+ukbale7ThOmeHiat7ZaUNTSixsERHm7DS9Gzp/yWVq5K75Lsf2P8OlXR8mIgCyv7u9J5zoL2Hs+W+HWowfo3EiCBTl8z57O1asHiFMfwAh3GOj5+cws0fRS0QWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319669; c=relaxed/simple;
	bh=Px45QG5wMBqsx4SLxUDpTdTfuK5HQkGCkKpsSNEkaUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiAB7kP6dW4nc/YHejMPoqntnuvG4UZQmPIn0NqMlMAeOAHFVw/JsoJlh7GVY0aq5QjUZqF4IXq3A4Vq0d6SSpSjGb4wYVZOONESayYz4exHjdYP68hFBX4cqrpKYyaPCn+v3oQPFlZClpZT6fobJGld4iXONJXFc8A5wrNFgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=XZC/tRi4; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="XZC/tRi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1732319660; bh=XcebQec07jzXTrfAZrzNgm8590Jm3hrgaHHTMTCk89Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XZC/tRi4t09ITL1yQgQNVgm7bS2CHeL4WpAYAWdi4nLmvkjYudsZHtxlbOB6Uc/pfBempfsnigy+LZznig7pjIqFhNE5MDoXDcS67c0Qbu6LMUbc+kCjfhKTlNyiJfAsM7WNa8kjbnexbi4FF4Px8gG0ddvsu82jq+XCPef/EINK+ZO26zvPr4kp7q3QZxZT93x2KThCAcjwyh2nNq+nKDVq5gUi9z7JIP0BBz8yJL2BT2QeB3ei6UzDF9xFI+JH0b5ETVrWeKrHAfNj04V8StEK7gChYVkepJaZRjtf6FDGZ26pMRtdtlCo9JrkvbKljcK8EqMaqFI8vyr0crQevQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732319660; bh=X5/068k9a7Io1grIvOcTalFLcllga5dcqIVD3ohnbKx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tY2SijnqEOHPWwUYUAuw1X8iY2zhfejeAuNskkGGZzcDOP1sjKWZOlA86n/hGte1QRoKXGXxJXBbH0LFTcR+BHQa+yZP2IQ8NN+hwjRewMoyKEVrA8MfS/dfKO6A8idk8Fhw+gLkSt1L9FSEB1oIha5ZrV/IR02yyP0fo4VjdPpqx0IWvgayI/xKL9rsdd1ggHUzsjr1IohZfnoTtIKiz13JsxH5NfCRF32dAf8uZ9UyXoBPSUYGYJMHsGXyiO8oYSODs8MzNxe/PvE9gURTSQbwe1qgV5/+Fjt4bRcWaag0jRQvI4MfqEwuf72b5epQ0WEshS8+ZjK+bxb0A6kPNQ==
X-YMail-OSG: yi9awj0VM1nyy_7ywC5wCXozf9vWpwY2nlSjsz8nzVsoiaukq6iCBzr5LEedNrN
 z055cdqB0bfa9G7ecbt_TWIxRG8hadwZkhApCeikmWV8GLjp91gCijVWK5vE7Elcc1gV8vmgmQgK
 m6vVwZ3.s1oZPhj3mnC6dut6H3DprMr.0Vq6TMEbtD3IOWMM9q2yUlgmPFZQUsSt3ahHv5BSU2Vt
 Pkz6zyXz0MCwv3qCE4gQa_KrxoJF4.47xkZg32xKLrxEtIQcN5n06pN85AhA26GQQkRWJHrCw5Kp
 WTJ5y6e2XNilxp_mhYDj5LdLJGJjgka05En5HQ2Q7nnkyNqFUGaoJZinoPMm8G9Mb8DCUXYAFBB.
 To5MMGGMYbuyDR7y6w8l0p_wkR_kmG5ROQmsg0f8CrtuETNIPdmYBkIOnyHz9hkpR3LTZGPUQlKE
 Igq8H3GaPb7NUZ5_fSXeb9RXIFwhgQkK9AX3X29awRypxLL6LfljiS8W7UojsDde3pu2bpB26LcO
 bQPXvBqoOFdvbPtXMCDsFGS.J761yxw_LO6.KKKZTp7ha1QM2PXK0GSf5fj5Yl9Tod7u9Cg3PB8L
 ElYPjaMC45kK7gXyFfD2siofq4j7lPzJabLMnurvxtGAJFW7Y33k9j3hLE7WTicWzK2ivCY0AU2z
 aCGON1HDrZ0KgQdj9rmw7yXHS_RgiPwIS.EnKQWpEc3JZTNtXZ0HHHcJsErrFw_FBrEluTkaRSue
 UnVyN9r7ZogweQvkU7ZpWEfpTxiW3fxRw_26tnKu4ZqH0726QCcCotu4_NaTxhHHn79iYkjCRDI2
 7ErKxvw.JM6z0AZ_E9r8R.mj0ZOeaY_opBYTrVFiLpJ9Ih2kMP_vufnXxFDWpnK9qHTCh4X50Sns
 EOBTtjbyICpZpgU4g6aI1ZN024wUO6S4yUM6C3TBpBhQVeu8e_gjF.0jLuYYNPCdZEhqF52j9AAS
 QeInk2ba_VcLzCN5b560oaxOHmJ3LhpjFyI5Sz3_IewMxnmMPE2sUeDtjNv2DtuHPa2Mfm9uYIdP
 D4ajVEDWLYLgF1nMNoBizFeh6xUIHZHNoaHhErdNJJFy6PBzD0A8WoomO4HAhk17mTiNk1IKX9L8
 zd8YL7E7C7R8IIHE7TfgLHA.cE.hRaIlm8GV4LLbNxhjCaxR53ZmNLQ2Om7406tNNiO235UXNdPv
 gSolpn8y0HkEZ9D0B6pgaTf7MqiMlucLax.ifBTz0tC9g9K.lIAQjgR7zvQaD20_5DG9aQi9yYLU
 GZ1nNXe.Q1d.lhZNu2fgzX2_Cf8ybJ2yIR23KixNZxcPlGXRDrP2zXmcylAn4VPe9ebuqvovDSOA
 56VeZyfxVoENTBvz5VA0ZoTSNzXaOj.czPBbxPUxdPdR.27nGRJUkeS9u2HbnBjuPVn7k3Qp.8Qv
 .BwLCYdjdiwmQE0FqK4.lk1z9RmA8pM_oUfk2MdZs.QH1ldLqq_aTk2ApbtzTvH9VmBHhorFTuN8
 vA.psnuY4QLdFrqZzMcC24wqfdL_BzwBy1YdveOiGeDOUHte8UB7n8WeYURZPBJHDYDFJDBtvOXM
 4FKGqwKEeFWqsZ_k1o5pg1_a.qrBJdBOvkBpQM1r2ylD5ZzLrgdsU4SYNDU8bhi8jDCO8rvXh0GT
 7_TEyNI2xMVZqZ7cFn3Fhiq3.e5fCCCmaPnqyiaEzvE91a2V2znCKYikNKXTCdfcPigSd0u7GoBS
 jT7Mxd0n.rMhwQEDiArLbn4Uw9587tvAcuR.ZrPep9vpdAJOWEsB4z3k326lvG.B2Lr4Mt_EJZb6
 6jEiayAdROMZ7.zD5KxGGIiQjw83j6YoUVC6FE_KQ23EFthjXoIs022FriQ1laGnIoeaptEr2HiY
 JWYckmnFR1CRxFL0GChUuiTi6F.LZyWRYRlbq.6dh4bVhtBNZp2HTHcOwuhVeiw3mEb41n1HAl15
 uB0yuzAhmi_AutUzr3TyHb_Eisq25crcIRQXKiOx3yUqSt8MAvhOtyPY_nHwuD3nVMnPBd25Xte4
 X6zukuZCkGXzPit0GHRQFxDCwXqtCtS8KkTJN0wFeFbqHqncwW_Cx5x6HTBYc.XgAKgD2SScwxAq
 3TuibtqnlJGyr5ipMVbOQ1H4ENQslHDEAXFDOYbZ20k90F0QCap1abAsfmdCvnLlvi4WhQi6SSbd
 GXdf9S28WAIV0QexnipbAHV4bBxEkGb8VKKX3jU6n7L1MRDzo_6geP2066Qzy2zGAPu.RnapB_gt
 RnRKnROn6CnG0dP9y_OdGalsnowHM8sTn.83jo0k45RiuWAbHLZv3wR.CgyZM_V0csDwlfxEmxMh
 3xogF88WpUvWkH9oLeA--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 9ebfe8ec-9e56-4838-89cf-aac4788eb787
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 22 Nov 2024 23:54:20 +0000
Received: by hermes--production-bf1-66bb576cbb-dxqpr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52fa6f45a421e925c7017fe74ca5f885;
          Fri, 22 Nov 2024 23:54:19 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Gil Pedersen <gpdev@gpost.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 0/1] Fix to allow more correct isatty()
Date: Fri, 22 Nov 2024 18:54:17 -0500
Message-ID: <16989967.geO5KgaWL5@nerdopolis2>
In-Reply-To: <20241121111506.4717-1-gpdev@gpost.dk>
References: <20241121111506.4717-1-gpdev@gpost.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thursday, November 21, 2024 6:12:53 AM EST Gil Pedersen wrote:
> This patch comes from an issue discovered in systemd, where it can fail to
> restore a text TTY session after a GUI session is stopped when compiled
> with musl libc.
> 
> The specific systemd integration issue is currently resolved in the musl
> master branch by closer aligning the implementation with glibc, but the
> underlying isatty() implementation is still flawed since it can return 0
> (false) for something that is definitely a TTY. Essentially both musl
> and glibc give up correctly handling this case on Linux due to
> inadequate/buggy kernel APIs.
> 
> Thus I am proposing this patch as a solution to fix the kernel APIs. An
> alternative fix could be to add a new IOCTL to specifically handle this,
> but that seems overkill.
> 
This is pretty cool as it fixes the /dev/console-is-a-disconnected-/dev/ttyS0
issue I found this year
https://github.com/systemd/systemd/pull/33690
and

https://lore.kernel.org/all/2669238.7s5MMGUR32@nerdopolis2/
namely on vt-less kernels that now have /dev/console as /dev/ttyS0 instead of
/dev/tty0 or a virtual device.


So yeah, when you have hardware and you've been using vt-enabled kernels
on it for years (where your /dev/ttyS0 doesn't even have an rs232 port, let
alone connected to anything), and then when you upgrade to a vt-less kernel,
sometime in the future, because of systemd's isatty() check failing, and
refusing to write to /dev/console, Plymouth's new log display facility in turn
gets far fewer logs from systemd, because of the ioctl failure in isatty()


MY idea for this solution was that kernels turning off CONFIG_VT_CONSOLE could
then turn on a CONFIG_NULL_TTY_CONSOLE that would get selected at the same time
the VT console would have, so that if distros choose to do so, the virtual
/dev/ttynull device to always work for User Space. (that way kernels that never
had CONFIG_VT_CONSOLE turned on won't have a behavior change as well)


(the one benefit to my idea is that Plymouth goes into text mode logging when
the console device is /dev/ttyS0, so Desktop distros would need to add a new
"plymouth.graphical" to their grub commands to get the splash to work again,
however when the console device is /dev/ttynull it automatically assumes that
the user wants a splash screen.) This is more specific to Plymouth though


However testing this patch and it also works, and this won't need a new
configuration change.
> Link: https://github.com/systemd/systemd/pull/34039
> Link: https://gitlab.alpinelinux.org/alpine/aports/-/merge_requests/70711
> Link: https://www.openwall.com/lists/musl/2024/08/20/2
> Link: https://git.musl-libc.org/cgit/musl/commit/src/unistd/isatty.c?id=c94a0c16f08894ce3be6dafb0fe80baa77a6ff2a
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=32103
> 
> Gil Pedersen (1):
>   tty: respond to TIOCGWINSZ when hung
> 
>  drivers/tty/tty_io.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> 




