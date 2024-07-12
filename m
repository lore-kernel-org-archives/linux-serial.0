Received: from sonic311-14.consmr.mail.bf2.yahoo.com (sonic311-14.consmr.mail.bf2.yahoo.com [74.6.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC651426C
	for <linux-serial@vger.kernel.org>; Fri, 12 Jul 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807589; cv=none; b=qGPEVFdl9onYJPSDnwC/SSO2iOnc33yND/K57chU/jLX2IfaDrbnwJUKnCjSvk2TJP0BacQby4OrlKb3QDTYM5LW3GijvvkYW5H3JvBoeePFv2Q9+F5IJW2cH7sfeLmE33IlPU1vlArQvoCnLPZZngABm6NXZ+CnJpKD5Q7ESeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807589; c=relaxed/simple;
	bh=WlGKpvlNF1lzFDcxufqLDraiNz0X7f/75T7wvtywCq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=HuGaPC7BZlJwITSS70DH5+AdrxscRDiJZO6ce/CKMbggNilD67aU+PATUpmc9r15kNOzSxS31d1r7SCEOjDegrkU6j60+4zq9Tt7BaWuBCf6Svl7SWn1VocdzcQTmCXNqlQoRsmdCK/Ei+MU8q+CghXDAb09KrPiyDS+zZo65nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=FaJqkP6r; arc=none smtp.client-ip=74.6.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="FaJqkP6r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1720807587; bh=JPSaYPl5e8ipRPWuWieBl3AaPuOTC1l4ulWSr3aNPl8=; h=From:To:Subject:Date:References:From:Subject:Reply-To; b=FaJqkP6rzag3neXk12k3mimAbHkMGdGHmCWKMs3s+11rzv3JpPQb3zyKTnQeItqYNW8/Ttv/iaHYE96kTlmMQ5fbgeRxXa0cjLedZYDgeegV9Od3F8+hIwdzh2X+LkAwmXBZZVvP8ymslD9a23D8J5wZBnYyDOHfIiiONekWkMVcnKJSwiUtht7K0ftBISYUlBT2I2cAs8I/3HC/385GP6PmCZ96q6n8tqMZ3KBh6unufDlqTYXZ6tfsPD6f5ePbpqtDYY/7SgAHQzTV/5+WzIPBviw98Sr3tFhHKMhR0Gn/FeQ1m/5GPpapxosiT3dL0nfFSLnPRVy5w8RTkjKUVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720807587; bh=RdQJVDsEi7vLGgUm5D98YLhzVZ16xJDnjsIzmwmfAvY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VZ0JpyoNjL/U7g31929gEIhifRuXm6jH6W1q4cwjJhn7LAtC6OVZnLlt750A9MnjkhCb69VGvu4bPKEdqB5ZcuuK/P81GteXwx7I2PUHjr0m8AorKmLME+J6Mkl0RF0i7JHahFAUitlY89JUKu4eJfOOsF5BU5B8WNfxqo9jhcLrvVn2abLiFFEa5IrQBVrIvb30gbkGfhNx3mChs7s2An5g5oIVRGbETSCz2pkRsyqj4scB2KzUAqAfeyuw1DDNrcEn8rk5BeWHwmUkQCzxJeLlViKPm3veMWsCXiGjvLBDMk3ks+RUTC23wacUIEjN8d1Oz0juhmBlvu2eU9UbMA==
X-YMail-OSG: xP_Xz6oVM1lIP14Rh1La.eiGNuwIT4N6f6ijUJ0M.kVPTVltIWpriVWQ95gcZBc
 yTCUYkkGMlz1elTi5z67VIqRtPU5bmr4phvvkgaKTmhmq0kvkwF.Zv4Sv6ag1p47WelZ9yehDWa9
 lQNXtu9sexBk628YYgS5vC8FZoYfLCtQK24JJqp43sq1Gor2P9Rn49xmGjIWHdriM7LfTr9SwB2d
 7PyYLFZ2lk5Q8VKcHZDrvZudPPeGvze_Uqw9qauKUQEjsvR7l_VV6E65sCka2i5Dbh25SlUAQc3M
 is5CU6pqQYVaRWiNAe7ZxJjUCtdKerlWhGkTXBTm7ECD2V0wDNq41VLMBqazp6ahD3IMuLdxVT58
 zMefHglf4txGEcgKQmiprnCCYUGgssDhaADdKGHYM3O5.9em4kWY5IbGzuIpjYkAKXJN0.wp8hpv
 T7nzIKCwh1Kw4iqvTqQpOOX_lGmrui7yPbvxKNzQAxgdomyqCO.VqEi2Flu_uU4Gyp7w_a3ERHrA
 zp8WVtAQBZZ.SSpeJQhjcy2TSL99V8ae834OB0Nmalcq1TecP1vu1fkXRRestmId6nmVGNKlYiav
 pBKnMvHNkVy1Aqp8HPgbg_PYeoy6yHmCtiTn3PJTtr8H.RThjaqoQTjoGrkRW5ILquQBTIAOXSDO
 9_jWcWLEekwlJ.lk0XSCgWXY3.EfmRYGu8FBiZ4odVGyW4pb2Rfa14.M_uTf5ID1qo4E8B0.Qr_p
 G9NIT.djc.AVJWj98cmf3nKYVdsve1rgfwP5yVLZDJQqIdSs.as5kLHlhbbip1SaGCIdx8NEVP_1
 YKy7XCZL9YJZDWhfuz3zBaJ8fZsgnFIj7n6OV1N51ANVGjXn4_yL9.BpgDW1WPGkMzOYGl9Tt8p7
 QG_.TLt0sf6qy1dWkLAalciEOrY1gPe.DGHYixFmqiuGgsePdCLEVUF.mSrsxZtukCGHdjvCaDiX
 t4S7XWos6Y0vfpuWtgUbY61p3rYoAs4.X2kvWBgk1y6514S22570p3O9Yqi3ttUERCXgvjal0Uzb
 8HZgBL4g6fPhZt_3Shj3jTJrJ1tIJZX1p9.Ul4AVXUoONXKW_2uC3w_X.EfJKE1mlSZFZG.ussMf
 Vsf8mVJOVy0cvad6QIKti9rtud17vNDtsOe3M9iy64EgrOpeTbhmqqzGynIV28Op3HEeCcyla73l
 zWtvgi1FnFmlgzz5dbbmT2xO6tht0tBJ7O38mF0zt0e3Qrr3s3ODMRVdywdNSRwupOevmUeqzbdD
 Wejnpf5tdUxqC8o00aWSu3CrkxqlPmDc2vZiTG8O1l15gfWjOz_ohDQqIR18YaJXVUchv7qzoGVy
 5Xn57wERBzLffQeEX0f1t6H0.kYhQ0kpRJuC_R2T4Wt8ZK7Y0s9EWSA6NAmdjH1ooDkgynEKIGMR
 urTD8dYPGleOWAYnNf33.1K7GU_qFpHTNsjPhETcWC2uOzs2nKrPy9ytGM3HaRkJTo6uaq80qL9s
 cUsAY10in_Mbd0Hq7oX9NSMYsrGWvGnfKHa25dvg2jtOeECgJsJ1tBFsRhdkA.M7ghwq33hkOkNq
 sDtUT4bW.HvOLQPFzPu0vQsG1hsLdkF7JhYAhtDxiHUq_56C8DZlqqphmZFp7mX2AXnXw9jMDKLk
 ij8q2uygQjON3KRxCbl9ZP_PHPzPGKtSqSEOCmVWvZrRqfoajEuWQO2r4Id4HPP5wFovupm7.dIC
 WfXMbZjqeX1TJ41rJLPw3cEXSYPg5bfMWCW9Mcsn_EkmpZBz9VRHIWmugTcxOzqeOa7H5qHKsAYL
 kNH1E1VqvxlklZ2nAQuHbUq4mCwO3WH5JZVXlT7p15eQA9Mh4nqIZgZuogSNSXDbLqN8f0bhHI4m
 TQ7VtoqU7DnfgvqFwbsRE1S1C3lCErDfwwTqqvO6WE79MIiFRi7ga1vXGuvDX37TAZHs59WJ2km9
 nk20u3diaZPiwln.A.YqlOS_rlzTJlUJ_BcqaDIdyYZ8aUsLgfrFQ6jGBi6qZgwqoy10lcYk9RyN
 xfHkdkCOa3FgUABG5zaUP60obA6ozIMho_7FaCGE4BuE40tUVkBOg94XCZBkXKZq5hekDLmQtEN8
 Xz_mJ2qWqmPAf8_94ioVxhB7AxIW_ivDMMvT9BQ50fkJ3c.E2XPsX9y6WYFJGa9MfC3EmNpUt_Pn
 qMq91MHOis8xpg.FGcmWKV6o98FJtfe1TwuKp..BcTMGmARF.DQof_V2QcY7_ROQ_3xB4HRepM1l
 ucEL6ybY.X0sc.hNcLmVT5E13wY2NCbQBma3cj_Np7najEYv3BYpYBU0.uQ--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 656020e9-f2a5-4f1d-b5f8-25bc94a6537a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 12 Jul 2024 18:06:27 +0000
Received: by hermes--production-bf1-7bd4f49c5c-9tkdt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 836e3dcf6b04f831b9630d063d64fdd5;
          Fri, 12 Jul 2024 17:15:49 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [Resend/Correction] When /dev/console is a disconnected /dev/ttyS0,
 TCGETS on /dev/console results in EIO (Even if TIOCCONS is called on a PTY)
Date: Fri, 12 Jul 2024 13:15:48 -0400
Message-ID: <3245549.5fSG56mABF@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
References: <3245549.5fSG56mABF.ref@nerdopolis2>
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Hi

I am resending as I realized I sent in Rich Text instead of Plain Text.
I am sorry if any of you got this duplicate email

Background:--------------------------------------------------------------------
This issue becomes evident on VT-less kernels. As when there is no /dev/tty0
device, the console defaults to being /dev/ttyS0 instead. Although this can
also be replicated if booting a standard kernel with 'console=ttyS0' and ensure
nothing is plugged into /dev/ttyS0.


This issue prevents systemd from logging to the console.
systemd when logging to /dev/console, long story short it calls isatty() on
/dev/console, and when /dev/console is actually /dev/ttyS0, and nothing is
connected to /dev/ttyS0, isatty() fails on /dev/console due to an input/output
error, causing systemd to not log the console output, because it rejects
/dev/console as not being a terminal.



This is noticed on a VT-less system with Plymouth. Plymouth calls the TIOCCONS
ioctl on a pty device it requests, to redirect console output, and in newer
versions, it displays the console logs on its own without the assistance of a
VT.


This part of it works, Plymouth is able to 'see' what gets written to
/dev/console, log output from processes that write to /dev/console directly
(for example 'echo hi > /dev/console") do appear in plymouth's
/var/log/boot.log, it is just that systemd is not writing to /dev/console
because isatty() fails to report /dev/console as a tty device.


The alternate fix in for systemds https://github.com/systemd/systemd/pull/33690
is believed to be that when TIOCCONS is called on a PTY, or another terminal
device, that trying to call TCGETS on /dev/console should no longer result
in an error.



Replicating the issue:---------------------------------------------------------

This program replicates it:
-------------------------------------------------------------------------------
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int main(void)
{
        int fd;

        if (getuid() != 0) {
                printf("Must be root\n");
                return 1;
        }

        fd = open ("/dev/console", O_RDONLY);
        if (!isatty(fd)) {
                printf("err on /dev/console: %s\n", strerror(errno));
        }
        return 0;
}

-------------------------------------------------------------------------------

When the kernel console is /dev/ttyS0 and /dev/ttySO has no device connected,
it prints "err on /dev/console: Input/output error"


When I strace it, the relevant line is:
ioctl(3</dev/console<char 5:1>>, TCGETS, 0x7f...) = -1 EIO (Input/output error)


I have not been able to come up with a proposed fix

Thanks


