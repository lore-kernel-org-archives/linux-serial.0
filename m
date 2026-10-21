Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605521;
	b=EoKeqIPAPeQEfbCpd2buLmmJ+uT3U7nU2zMpeBiJuubuka8RAWsMjGJ0GCIDeNRqdBjN
	 ll7E1btISL6Cn5hkEhFGPsQuoeXHWzqBaQI/q0H1DezelN0OVIBXlrtrz9tR6B4ew36uf
	 /poYzBjoULytJLu/ryNx30HrkVRttPxnJcGOSWhyv1OuYmxyZkYvcTCAgCQwZnqZ8OcNS
	 k4nFXV/LlyW9+OjzMvQDhEoG8IkD3sPPx06nXWKOLWnO3iWAkDdsmswlleZg0t2GVZbBD
	 cM8UOn5TJvIBMQ4WtxCC8pZ9mOv8AVsZfki7xYr+o2aA8pt0GNmNF7YP6f14TsASF9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ha1K352wfyqdFbF8DNVmHU8vhoz9syKvY98S4jY+g6Y=;
	b=BvFHK2iuX5Y6iuFN4flJd2OJudXPL2Q7AQa8yHOqOst8McU4luehRqeObRiLiZAQw+dP
	 Lq4nlDpUDZzt6yPuGPSH6fOMx9M9BkUPFBDiM1MMReQ3Mpt5i5WZeTAR8gR3k0FWIj1W6
	 8QoZ+CN4MwJOl3wZ8bJbztE0UXrS7Dj58H0qd7BjV/VKxmvycDpXuSCM9y8HftSlD3LUL
	 KVnG476HrPKM2fX/Bt4sgvWyRYmzcpJWcj06QktIneJHjj1JQxF2zL8FpnGYhhB3PznFZ
	 che2vXXWS6zpwZh+4gt3957JaXbM3aGvmBcGG7xwfRKqi+CxQ8KmnhSMm8VPTZnbRSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FT4pwh6g;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371B606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 17:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9371B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FT4pwh6g
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98febe968deso701888241.0
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605519; x=1793210319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ha1K352wfyqdFbF8DNVmHU8vhoz9syKvY98S4jY+g6Y=;
        b=FT4pwh6gpGaIQ6svkDMoqALbka3hBJJwgkHvkiaYv/qNWOGa5DhCoyrhMuH9rgTIJx
         baThPsKkl3f9EaTmvHlonm7bADrrg1Bu3W2cbchx1i9d3oEFPmfwzJxAPDW0ND4ZB3I+
         8DQuQNXHSbB90S/57d7YMWMBAN+tY/0o4x8VIb8yR321706XWUmk8ZQkkApNsaZO8Mxe
         DnMdp053VU2HdjfXWOS8Z1gwoLWH4Z4FVQa+9M1+llC5mYY87rbhsSNrgmcDyFPxLoeC
         +rAxusdHJf0kJ6URDKVvZa/j2/fs3AatLn7za+iZP/Pr5A66JlTmX+NV8duUTeOHKxkG
         a5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605519; x=1793210319;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ha1K352wfyqdFbF8DNVmHU8vhoz9syKvY98S4jY+g6Y=;
        b=FJfwLCgns9EB8iJ0T4+T+GQiprgGl3Tbhq/qBqaFq/bKl0i/8/twoz9wB+LwH2pWKM
         Ramg5H0wx6RRbMpdDTP40wEN/YtUtt4GbnBhtIp3cCEw4m/3XjilV9LU96FuSPXqW/Wv
         JnGeuNi/yRkXmqYCXehpeMRKw9fT/22cvhV/jspVdBUmhiLbrwKdBdz+pvjAHncyRyGO
         Z+jQQY13ZP00nC54nJr2sqOKJ8Rno4wgQ0nkRKEO3SEdEA1/80LogBgdmrlYvGgoLeZz
         q52NBga+nPalUpsM7iJfDpwHjOlq38YdDgaghAzJThrpdwqFSrtx2Z3LycpQKOpnC4zm
         AxMA==
X-Gm-Message-State: AFq9FYLCbQdaURr6rl7aI2Rh8A7RwSqtEzZnEhqmWAK3Sq6hkhNXyy6U
	nCQtgr6Ga4sPRo/+A40QLv1VgU2DlP+mW0DKjoIwAhkUssB28e5nWHFc
X-Gm-Gg: AYBFou2PAfjqgKmOXRaCfq6KLn/m1HF2ZiRzWFLpf6f+7T4ONC+tQE4+ldFBI8RsyEs
	erUzXo7ycKEBHi7OqhZjKRygrdHOC/V2pfwU5n7t4djwOvWU+oMeCboqAU29I2AJkJOGMIepg5K
	348ag8LCZU4XdnYtLM6+ZEJxXGa0JDJpQbQiLFaaqKdclnkmcKqAHvTC3rtHhbQMKO2xfN861fd
	k5rDMn4rdpy68PNnBiEvCiTA15kJFg7BJaEW5ujO39dQ+XM3yV6GW2GhdvXM9ABwXhn3VwCjIK3
	Tt4cmYTsUBuFMHmoC8fceMLoPvHDpMmIPjnPqM1e23ekYlm4FfMBkhwgsTMeMLPdwGHmxWOtcTB
	flginpM0m/LCxiU5ni+RJ3wwvupuBYm+pzHvjP26wqY8hg3iVsRnp/NA7OsjLkkszyRkd1Nhdmc
	dUVUbpcS92iT3ybOd7ryktCWRJrK9cjYig9rZJMtoh37B579pmlZGTqXBktcL1LyMltxiOiz+w0
	Ye8nSNLtdSH6vE10vM3b/7ZLtlvwOuGgNPiq9v10+edZQOGs7Wt5C79b72mTwGswhN5GvTd6/de
	E/AEsa+moDmztzcQPe6anTlXjnI5dUYd938fhq/iEZ42qHoN9E9PNf6zvdTelNptkV3BrtkF+kj
	spl2YXU8Dgw==
X-Received: by 2002:a05:6102:508f:b0:7c3:872c:8be6 with SMTP id ada2fe7eead31-7cc9271966dmr1231907137.25.1792605519613;
        Wed, 21 Oct 2026 10:58:39 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9788c68sm4090944e0c.5.2026.10.21.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:58:39 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	ilpo.jarvinen@linux.intel.com,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733
Date: Wed, 21 Oct 2026 14:58:22 -0300
Message-ID: <20261021175822.318717-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <414bbb7a-1018-41ac-a580-cd41708c6a78@arm.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <414bbb7a-1018-41ac-a580-cd41708c6a78@arm.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andre,

On Wed, 21 Oct 2026, Andre Przywara wrote:

> So if I understand correctly, this compatible is really there for the
> clock gating issue, right? As the DLF part is now somewhat correctly
> auto-detected?

Yes, the compatible is only for the clock issue (SKIP_SET_RATE). The
false DLF detection is handled generically by patch 2.

> Can you share what your termios test looks like? Because I assume this
> affects more Allwinner SoCs (the DLF change definitely does).
> Then we should add more compatible strings here. If there is a simple
> test, I am happy to run this on a bunch of boards, to give you a list.

I reduced the termios test to a small standalone reproducer and retested
it on the A733. While the serial console is continuously transmitting,
this program toggles CLOCAL and restores it:

    #include <fcntl.h>
    #include <stdio.h>
    #include <termios.h>
    #include <unistd.h>

    int main(int argc, char **argv)
    {
            const char *dev = argc > 1 ? argv[1] : "/dev/console";
            struct termios orig, changed;
            int fd = open(dev, O_RDWR | O_NOCTTY | O_NONBLOCK);

            if (fd < 0 || tcgetattr(fd, &orig)) {
                    perror(dev);
                    return 1;
            }

            changed = orig;
            changed.c_cflag ^= CLOCAL;

            if (tcsetattr(fd, TCSANOW, &changed) ||
                tcsetattr(fd, TCSANOW, &orig)) {
                    perror("tcsetattr");
                    return 1;
            }

            return 0;
    }

I compile it with:

    cc -O2 -o clocal-toggle clocal-toggle.c

and run 300 iterations from a shell on the serial console, keeping the
console busy:

    dmesg -n 1
    (while :; do seq 1 1000; done) &
    gen=$!
    i=0
    while [ "$i" -lt 300 ]; do
            ./clocal-toggle || break
            i=$((i + 1))
    done
    kill $gen

CLOCAL doesn't change the framing, so the output should stay a clean
1..1000 sequence. A bad run shows garbage characters and missing lines.

On the A733 I ran this test five times without SKIP_SET_RATE and all
five runs were corrupted. With the A733 compatible selecting
SKIP_SET_RATE, all five were clean.

Running the same test on your other Allwinner boards would be very
useful. I also have a small script that checks the capture, if that
helps.

Thanks,
Vinicius
