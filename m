Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D6489897
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373280; cv=none; b=IZ+VSF+GgYzJoAeQEnXfJ43tLPXvyXKw0p3ViqSOyYWfAX+IhixTUc0GUMPjxQFjthqOlQLf/e84LQU0sSgn0jO5unA0bC9ocb75pj5iB9UnSVW0HqmPYRLQKDO3SfmUM0bu/tVqJMUtGMcQKZZ2KexbyunI4ht3TCOi00Iwd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373280; c=relaxed/simple;
	bh=wziumXR0C0JuI6Dmj4K/JRRVx4+SJT/JltIQlJfsk50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsSuKX5AiFiJ6KWGVA4xMdc5pOPrtBSBQIUZRWNd1EWFDx60PwfzHCCUQXVn0QDS9p4dN0KYsNaUHgIWzwXRxtbX/Ln7lAOVZA2PLmlpBYv3Fq0GBIJhqALKEsKnsHWts1z4rqfnGs0Rh4nWCFzOXK6hpJKbdgoeAVi0vAFqbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQYbzekU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQYbzekU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665E21F0089F
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373253;
	bh=wziumXR0C0JuI6Dmj4K/JRRVx4+SJT/JltIQlJfsk50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JQYbzekUcMuAPJ++XMZv4wh4ozvGN/Wy86PFLHAspa+xaoF9UcaS0BjOE/6kcYdGt
	 y54g4iwlDoOoeUs2zTB9S9S7qh82uJnlBIYKhyuliNQWl0ogxLAixR7uHQmZxndlvp
	 0Ftvx5cIrQVVq5rD/TtgPjGepgg9QcGmD0B2Ozj4sjfPPhRkGfjpVgq0WYA9CfT3bv
	 3d4depWwN1MAV6mlgyuF6dJqRqxz1ZCVviqMye4vX5Q5CJIkWDSZmZBKFDqswxIgih
	 /TI+4Dc2/IEzA4uCmhgWgvJaHigMF+hJWpjDIcz1KCycZub9JVsv7ODYaZ6fTtZo3B
	 7RWq3VI3Py3XQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6cfed5dd083so2916738eaf.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 04:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxm+7BFqOYxbaOrWBxuoyQIdI1uNRW4uRqS9N/NdeC+uI4oAty+D6lU+9yiZ/dYut4Zdh+VpdIZ8dbD2H0=@vger.kernel.org
X-Gm-Message-State: AFuF++kpcGx5UkUL6qG78hlghDPfFnVeJ2iFeX2tLlQjnNfnuzd3FwIu
	9KpkMx14stzVPkGN5C9i2pfqzqjdCylNF4rs082f90kFXEAn31IbYNfw+LVkPqakxeIhLETd+0i
	PF/P86SyqnPw0Yr8JOKHngKwBUxBd3cs=
X-Received: by 2002:a05:6820:1788:b0:6d9:5636:808e with SMTP id
 006d021491bc7-6e7a739112bmr2000179eaf.56.1791373252731; Wed, 07 Oct 2026
 04:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com> <20261006-b4-cs75xx-v2-6-b7d6e1e24d44@gmail.com>
In-Reply-To: <20261006-b4-cs75xx-v2-6-b7d6e1e24d44@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Oct 2026 13:40:39 +0200
X-Gmail-Original-Message-ID: <CAD++jLkfyv96v0VQorp4izy8ivr5eCtfDDVoNgWf5TRyz5JXXQ@mail.gmail.com>
X-Gm-Features: AclHuK8byDgRIuSHw8cA06RqOCCjXEr36nPZzKXnufFQprrALuEAe-_uffVuuoA
Message-ID: <CAD++jLkfyv96v0VQorp4izy8ivr5eCtfDDVoNgWf5TRyz5JXXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
To: filipp.dunsky@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Jason Li <jason.li@cortina-access.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 8:17=E2=80=AFPM Fil Dunsky via B4 Relay
<devnull+filipp.dunsky.gmail.com@kernel.org> wrote:

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
