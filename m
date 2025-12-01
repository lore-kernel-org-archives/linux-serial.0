Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFF13959D
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764555998; cv=none; b=gpkmLgPy7Bux2zfDitJINUU10s0EvB+xkT4+Y03XsCKrhR8njuYTPUcV0uERbQ8404qj14OXcaBinPBXcflE70K2dXAKfLoShYYYZDubdWtIxjhrCXCJZrSsolAR2gmZaU2Wif+xS7CgrLBoqm+QMTAOD17ZUPu7DlTDJVS1SxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764555998; c=relaxed/simple;
	bh=PuFDtol3ZnnxpVa85gSNM3JDboTkGpyxcNV7qTA8rNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDM0Fu4GbOeXjAWecP8IrgoR0aK6+KnetM/uAHKzEEHlu+lb97t/nURxs5xlv7yr9YlkropqFwt3wGRkin7k78Q9I2PRMtnXZ7sbrMAvTP1yi8zX6FMMIRIQzZ1sJPtx2DvtZRDBqgRb9CO+ckua40c3Ac2g0rRskNWIubqO4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eindgcz2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eindgcz2"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b735b89501fso455469566b.0
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764555995; x=1765160795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MTD0qfenQJv6TKu6nunQSV+3KqV8kyn2C16CIgskeQ=;
        b=Eindgcz2tyK7eAmXO1daiApuU9+5kBmcCp0tRnTaIiiUwdp7xd4RNaUelkGCMQwV4/
         Hy/gzU5CwTRrxlzhFVI1D01+s1o6FMLGNp9SdRa8ChDwI6m77HTbRyDU9Wc3Cy8GEicF
         ZZ8IF3XURH64abXENgjjGNCxL1zJn0NYJO5pbNfZEbrf2peAia34YNvyiKDXwabutUD3
         ++kP2AUTnPiXaXxfz7sNrp6RQpE6lvFoL1qWNrYUXiuVMh7gbwGgWXKbAAsTSKbp1Sy0
         taiZC1tDFFe9TWe3QXZY5+iPHvQO+Kbljmb63m5tBhvC4Ab8m+WgTTcW+WShIj3uvzzL
         OmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764555995; x=1765160795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+MTD0qfenQJv6TKu6nunQSV+3KqV8kyn2C16CIgskeQ=;
        b=FTFjXud33lNc4MdYSG6epz3lOwILu0SvYRqmXbp38B3oSTKNKkmsYIeCCQhMD6AZFi
         B2koDJmCIbfb6AemqHw5TKkTBSkgsZZvsLgZYEBaS4lOAQYBlyBSuiDSf/MtXugBgsA3
         Srn0jyqJFdAZqW3OdZM3nrbpI1vSNe2GGHSCGezae4/wuEYGxO5BDrMngwn8rxsbRpmE
         wwo594CjESOpSJFcnsOz3r/BtOyPHcrywAqg0o9lrc970Cs8QQsS+zB405dsEcdwqMx0
         UPtmcj08LwW1tprvlcnlJ+J24gf2GRlRrThpfgP99YyvdGAvVDTBjVkmfIMIemGtiFhs
         Dnfw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsL1omMLstD6V8XyWW64Fn4kKqCyL4woaI/kL5UYxuvELUGbZOTU8AL4rI2uU1bewmXwVno1MU2LB6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHqrAUh5sebwl0yU8YRKy42iGLE5B31fyeHoKDBNfZjgmMiAF
	Oh2c4j2VVew+ySoszRrTJCfKZS+bMiYQDDHk3hJGe/fy/uxesJI6reslsHH9kEgREGANIfGFGhq
	RFzYzczCBZqYKFxbuEN+CvS/lnZNdO+c=
X-Gm-Gg: ASbGncv/FpRZ9muwTHj43srVoQBNKlUbG0Qbad3n/ZNtM2fOFWqZwJEaxdxz+zM6nfj
	CdIzoPXduqcuCGjPDpAPoEC6jk8U81o0/O0IijcHIQuzcE7uQ0G2qYLesvygpM1BC6j8lT68Avd
	VdjHiJ+7FUeY8J+4oezk6weGuMMKbdEC3uO16Q/F4rDGAAso+RD6Qj5qKGMaAoW824tFJCUCO2p
	nBF69IkKYBSjQ0QfFpo1VETMybbP0gRrTSQzwM4j9KG4RJ6wkf4WMWO/eO5CjwBq9R9dTcUD4kW
	Da1ujRL72r0EPbjUjPnq3i5FpxcSX3vxBe4JxH0RUahOoz/0N7vtn8Ww+pnPaJIXWn+ai9QAjLs
	TpCJsiA==
X-Google-Smtp-Source: AGHT+IF94ymcPIaFtyhUD9ptgvjMdU71gwqHoPym8PiFuRqgQugYncVdUbFF5vX/KyWEszkb7fQuIY11SYi564TVzHM=
X-Received: by 2002:a17:907:2da6:b0:b73:792c:6326 with SMTP id
 a640c23a62f3a-b76c53564f6mr2579339566b.11.1764555994728; Sun, 30 Nov 2025
 18:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-27-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-27-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:25:57 +0200
X-Gm-Features: AWmQ_bl3OHwiD3d_-s2EWoz7CEtFiTW6BBDRpMhoy3ZostsGzcZrF5nIXlRetks
Message-ID: <CAHp75VfZ4GEKVvd2ZyR2wxHRPNej+_KbQja8KvucYGsTWrQsXw@mail.gmail.com>
Subject: Re: [PATCH v1 26/31] serial: 8250_mxpcie: add basic CPLD helper functions
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Introduce a set of helper functions to access the on-board CPLD on
> Moxa PCIe serial devices through the GPIO I/O space. These helpers
> cover:
>
> - Initializing the CPLD-related GPIO pins to a safe default state
> - Enabling/disabling the CPLD chip select
> - Switching between read/write and address/data modes
> - Performing single-byte read and write transactions using GPIO
>   bit-banging, with simple delay and retry logic
>
> These functions do not affect the UART datapath and are not yet used
> by the driver. They are added as a preparation step for follow-up
> patches that will implement more complex CPLD-based features.

...

> +static void mxpcie8250_cpld_read(resource_size_t iobar_addr, u8 addr, u8=
 *data)
> +{
> +       u8 saved_state, new_state;
> +       u8 samples[MOXA_CPLD_RETRY_CNT], votes[MOXA_CPLD_RETRY_CNT];
> +       int i, j;
> +
> +       /* Perform multiple read attempts with majority voting */

Why?! Is the HW so buggy?

> +       for (i =3D 0; i < MOXA_CPLD_RETRY_CNT; i++) {
> +               /* Set read/write pin to read state */
> +               mxpcie8250_cpld_set_direction(iobar_addr, MOXA_CPLD_READ)=
;
> +               /* Set address/data bus pins to output for address phase =
*/
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4,=
 MOXA_GPIO_STATE_OUTPUT);
> +               /* Backup current GPIO output state */
> +               mxpcie8250_gpio_get_all(iobar_addr, &saved_state, MOXA_GP=
IO_OUTPUT);
> +               /* Prepare address to GPIO bus */
> +               new_state =3D saved_state & MOXA_CPLD_CTRL_MASK;
> +               new_state |=3D (addr & MOXA_CPLD_DATA_MASK);
> +               /* Output address to GPIO bus */
> +               mxpcie8250_gpio_set_all(iobar_addr, new_state, MOXA_GPIO_=
OUTPUT);
> +               /* Switch to address mode (address/data pin) */
> +               mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_ADDRESS);
> +               /* Enable CPLD by pulling chip select pin low*/

MIssed space before */.

> +               mxpcie8250_cpld_enable(iobar_addr);
> +               /* Wait for CPLD timing (about 70 ns) */

> +               mdelay(1);

Why atomic?
And 70ns is more than 10x times less than 1ms!

> +               /* Switch to data mode (address/data pin) */
> +               mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_DATA);
> +               /* Set address/data bus pins to input for data phase */
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0,=
 MOXA_GPIO_STATE_INPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1,=
 MOXA_GPIO_STATE_INPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2,=
 MOXA_GPIO_STATE_INPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3,=
 MOXA_GPIO_STATE_INPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4,=
 MOXA_GPIO_STATE_INPUT);
> +               /* Wait for CPLD timing (about 70 ns) */
> +               mdelay(1);

Ditto.

> +               /* Read data bus pins */
> +               mxpcie8250_gpio_get_all(iobar_addr, data, MOXA_GPIO_INPUT=
);
> +               *data &=3D MOXA_CPLD_DATA_MASK;
> +               /* No need to restore read/write pin (defaults to read); =
disable CPLD */
> +               mxpcie8250_cpld_disable(iobar_addr);
> +               /* Store read value for voting */
> +               samples[i] =3D *data;
> +               votes[i] =3D 0;
> +

> +               for (j =3D i - 1; j >=3D 0; j--) {

  j =3D i
  while (j--) {

is much easier to understand.

However, the "votes" approach has to be explained "Why?". Bugs in HW?
Other stuff?

> +                       if (samples[j] =3D=3D samples[i])
> +                               votes[i]++;
> +               }
> +               /* Perform majority voting to select stable value */
> +               if (votes[i] >=3D (MOXA_CPLD_RETRY_CNT / 2))
> +                       break;
> +       }
> +}
> +
> +/**
> + * mxpcie8250_cpld_write() - Write a byte to the CPLD at a specified add=
ress
> + * @iobar_addr:        The base address of the GPIO I/O region
> + * @addr:      Address in the CPLD to write to
> + * @data:      Data byte to write
> + *
> + * Writes a single byte of data to the CPLD at the given address using
> + * GPIO-based communication. Includes verification with optional retry.
> + */
> +static void mxpcie8250_cpld_write(resource_size_t iobar_addr, u8 addr, u=
8 data)
> +{
> +       u8 saved_state, new_state, verify_data;
> +       int retry_cnt;
> +
> +       for (retry_cnt =3D 0; retry_cnt < MOXA_CPLD_RETRY_CNT; retry_cnt+=
+) {
> +               /* Set read/write pin to write state */
> +               mxpcie8250_cpld_set_direction(iobar_addr, MOXA_CPLD_WRITE=
);
> +               /* Set data bus pins to output for address phase */

> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4,=
 MOXA_GPIO_STATE_OUTPUT);

This block is repeated at least three times (just with a different
direction), make it a helper and call as many times as you need.

> +               /* Backup current GPIO output state */
> +               mxpcie8250_gpio_get_all(iobar_addr, &saved_state, MOXA_GP=
IO_OUTPUT);
> +               /* Prepare bus value with address bits */
> +               new_state =3D saved_state & MOXA_CPLD_CTRL_MASK;
> +               new_state |=3D (addr & MOXA_CPLD_DATA_MASK);
> +               /* Output address to GPIO bus */
> +               mxpcie8250_gpio_set_all(iobar_addr, new_state, MOXA_GPIO_=
OUTPUT);
> +               /* Switch to address mode (address/data pin)*/
> +               mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_ADDRESS);
> +               /* Enable CPLD by pulling chip select pin low */
> +               mxpcie8250_cpld_enable(iobar_addr);
> +               /* Wait for CPLD timing (about 70 ns) */
> +               mdelay(1);

See above.

> +               /* Set data bus pins to output for data phase */
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3,=
 MOXA_GPIO_STATE_OUTPUT);
> +               mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4,=
 MOXA_GPIO_STATE_OUTPUT);

See above.

> +               /* Switch to data mode (address/data pin) */
> +               mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_DATA);
> +               /* Backup current GPIO output state */
> +               mxpcie8250_gpio_get_all(iobar_addr, &saved_state, MOXA_GP=
IO_OUTPUT);
> +               /* Prepare bus value with data bits */
> +               new_state =3D saved_state & MOXA_CPLD_CTRL_MASK;
> +               new_state |=3D (data & MOXA_CPLD_DATA_MASK);
> +               /* Output data to GPIO bus */
> +               mxpcie8250_gpio_set_all(iobar_addr, new_state, MOXA_GPIO_=
OUTPUT);
> +               /* Wait for CPLD timing (about 70 ns) */
> +               mdelay(1);

See above

> +               /* Disable CPLD by releasing chip select pin */
> +               mxpcie8250_cpld_disable(iobar_addr);
> +
> +               if (addr & MOXA_CPLD_SET_STATE_BASE) {
> +                       mxpcie8250_cpld_read(iobar_addr, ((addr & ~MOXA_C=
PLD_SET_STATE_BASE) | MOXA_CPLD_GET_STATE_BASE), &verify_data);
> +
> +                       if (verify_data =3D=3D data)
> +                               break;
> +               }
> +       }
> +}


--=20
With Best Regards,
Andy Shevchenko
