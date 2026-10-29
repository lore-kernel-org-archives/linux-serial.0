Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252262;
	b=a3ti5btE8AL2jDbvpf8j5JoNiqiP/QqUPXUSSEQ3tX2cQLWq1EJI80i7e5QvRSeN8Tfb
	 tXqmxQs7TrwidO5hwlUiBIK3jl1/SYR4s+bUgjPj54VFwCIQBjtmCqKgUE7JQIE7zUe5r
	 +eAg5wBfB2+DGGBuiNZAHTlxofiLtxTMWB/FzYM3ZBJL4BxmYMW8kvztjmpqa1PMYj159
	 2SoniB5TgDDcSlBSFolTcL+92TjdhsWMOu+jS9RBX3drBWSFp4p5541iX31l6i034tERa
	 iIM3mYkt04XlNKse8GXPatq0gsUuLrwD76aW+3zcyACVpZYdyq4nWMsuyDxr4yBAWNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8/XVliNYGNf9Vr27hCG2GokMpwv3zf1D7CGTaejWL3U=;
	b=hNoiH4Zz2B5INrCX+K0pgm5y5H64vqdV1OktVnUZ25hDHmQHZEfjC4y8IX8dc1kstuVI
	 mseuHUSEKp756xdwstvJyDJ9bi99BmOALLYF7J7wEr1lLnTe17Kwr+0wX4uY8s0Red1kO
	 KQnKDZ6GLpc7ZLIPgRkT0b9wUuGpgkEBPWJb3k3bob0WV2u6s0jpJXY3g2TrO4IA71WGo
	 nLwq5tyrX5sVKCFhAAVCSlJbPGjPof+zKoudDoRb/YDwqe3fmZDMzdQSX0QyQ9j/NG/Mr
	 wOlV0RhSCDOHjGqk91nOcR2RxGljjHWpHXaHUP9818R4T9N8nTvudIJFtkViRUhO0mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6LF2nw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457C606A31A;
	Thu, 29 Oct 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6LF2nw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD03D1F01825;
	Thu, 29 Oct 2026 05:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793252261;
	bh=8/XVliNYGNf9Vr27hCG2GokMpwv3zf1D7CGTaejWL3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6LF2nw7FqMqiZ4oWjs7vFT3p3ywtjM8yVBk18nfQF2mzLxSYNDV4QPc5GqQ1PBNL
	 7/lM7dojeqpYTDZ2JCoIMUbH4Xt7H8A0xRetzeopO41iLfo6e4j+JvMdlVTCZ18nG3
	 4fgT+lgC2wnloI1PHuSsTbvJz8YcbTwEHJaALVSv6lqAFsHMV1HuBahhs9UX/bRWXG
	 RkhJRmWtWybFGhJx4yUcGItWAnxKz7LdMXRQyeUIWS1AMAtPrq8a4YfQf8b6YFu+kV
	 1HTptMaytWpB2Z1p2Jl0RsOmKMs9qY9aDOkGYjQKcREaD0f5tcbaLFxsX4grnLX4JY
	 +ldwUj0m+IRzg==
Message-ID: <sashiko-outbox-188759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/12] rust: serial: Add minimal serial-core polling
 console support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:37:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] rust: serial: use-after-free of uart_state on Driver::drop() w=
ith open tty
- [Medium] rust: serial: xmit_buf memory leak on TTY open when startup() fa=
ils
- [Medium] rust: serial: console_setup() and configure() corrupt console->i=
speed
- [Low] rust: serial: missing INVARIANT comment in PortData::with_port()
- [Low] rust: serial: missing #[inline] annotations in serial abstractions
--

commit b586ab9682dee028e1eb2b244ed7a9b0fb3bdd94
Author: Kwanghoon Son <asdfkwang@gmail.com>

rust: serial: Add minimal serial-core polling console support

This commit adds serial-core abstractions in Rust for memory-mapped, two-wi=
re
polling console drivers, including Driver, SerialOps, Port, LockedPort, and
Termios. It manages port lifetime via devres and provides callback adapters
for console output and termios configuration.

> diff --git a/rust/kernel/serial.rs b/rust/kernel/serial.rs
> new file mode 100644
> index 0000000000000..f24c685d8592f
> --- /dev/null
> +++ b/rust/kernel/serial.rs
> @@ -0,0 +1,505 @@

[ ... ]

> +#[pinned_drop]
> +impl<T: SerialOps> PinnedDrop for Driver<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: Registration succeeded and every port holds an Arc to=
 this driver.
> +        unsafe { bindings::uart_unregister_driver(self.inner.get()) };
> +    }
> +}

[Severity: Critical]
Can dropping Driver<T> after port removal cause a use-after-free of
drv->state when a TTY file descriptor is still open?

Driver::new() registers a struct tty_driver via uart_register_driver() and
sets console.device to uart_console_device, while register_port() publishes
the TTY device via uart_add_one_port(). Although SerialAdapter::startup()
returns -EOPNOTSUPP, uart_port_startup() in drivers/tty/serial/serial_core.c
turns a negative return value into 1 when capable(CAP_SYS_ADMIN) is true:

drivers/tty/serial/serial_core.c:uart_port_startup() {
	...
	retval =3D uport->ops->startup(uport);
	if (retval =3D=3D 0) {
		...
	}
	if (retval && capable(CAP_SYS_ADMIN))
		return 1;

	return retval;
}

uart_open() -> tty_port_open() -> uart_port_activate() -> uart_startup()
then converts that positive return value into 0, allowing open() to succeed
with TTY_IO_ERROR set. When console_on_rootfs() opens /dev/console at boot,
or when a privileged userspace process opens /dev/console or the TTY device
node, it obtains an open struct tty_struct with tty->driver_data =3D
&drv->state[line] and tty->port =3D &drv->state[line].port. Even for
unprivileged callers, tty_init_dev() attaches tty->port before uart_open()
fails and tty_release() runs.

Because uart_register_driver() leaves tty_driver->owner set to serial_core's
THIS_MODULE rather than drv->owner, open TTY file descriptors do not pin the
driver module or Arc<Driver<T>>. When a device unbinds and Registration::dr=
op()
calls uart_remove_one_port(), serial_core only calls tty_port_tty_vhangup()
(which does not free open tty_struct instances and skips /dev/console
redirected files) and waits on state->refcount (which only tracks transient
uart_port_ref() sections).

When the last Arc<Driver<T>> is then dropped, Driver::drop() calls
uart_unregister_driver(), which immediately frees drv->state:

drivers/tty/serial/serial_core.c:uart_unregister_driver() {
	...
	for (i =3D 0; i < drv->nr; i++)
		tty_port_destroy(&drv->state[i].port);
	kfree(drv->state);
}

When the open /dev/console or TTY file descriptor is later used or closed in
tty_release() -> uart_close() and release_tty() (which sets
tty->port->itty =3D NULL and calls tty_buffer_cancel_work(tty->port)), won't
the TTY layer dereference and mutate the freed drv->state memory?

[ ... ]

> +    /// # Safety
> +    /// `ptr` must be a PortData<T> port in a serial-core callback. Regi=
stration
> +    /// owns its allocation until uart_remove_one_port returns; removal =
waits for
> +    /// console_srcu readers and serial-core users before this port is f=
reed.
> +    /// Other device-managed resources may already have been revoked.
> +    unsafe fn with_port<R>(
> +        ptr: *mut bindings::uart_port,
> +        f: impl for<'a> FnOnce(&'a Self, &Port<'a>) -> R,
> +    ) -> R {
> +        // SAFETY: The private_data type is fixed by Driver<T>/register_=
port<T>.
> +        let state =3D unsafe { &*(*ptr).private_data.cast::<Self>() };
> +        f(
> +            state,
> +            &Port {
> +                raw: ptr,
> +                device: &state.device,
> +            },
> +        )
> +    }
> +}

[Severity: Low]
Since Port<'a> declares a type invariants section in its documentation,
should this Port construction in PortData::with_port() have an // INVARIANT:
comment explaining why raw and device satisfy the invariants?

[ ... ]

> +    // Required TTY operations remain inactive for this output-only cons=
ole.
> +    extern "C" fn inactive(_ptr: *mut bindings::uart_port) {}
> +
> +    extern "C" fn startup(_ptr: *mut bindings::uart_port) -> i32 {
> +        EOPNOTSUPP.to_errno()
> +    }

[Severity: Medium]
Does returning -EOPNOTSUPP from SerialAdapter::startup() leak
state->port.xmit_buf whenever the TTY or /dev/console is opened?

When a process opens /dev/console (including console_on_rootfs() during boo=
t)
or the registered TTY device node, uart_open() -> tty_port_open() ->
uart_port_activate() -> uart_startup() -> uart_port_startup() allocates a
page for state->port.xmit_buf before invoking uport->ops->startup(uport):

drivers/tty/serial/serial_core.c:uart_port_startup() {
	...
	retval =3D uart_alloc_xmit_buf(&state->port);
	if (retval)
		return retval;

	retval =3D uport->ops->startup(uport);
	...
}

Because SerialAdapter::startup() returns -EOPNOTSUPP, uart_port_startup()
returns a non-zero value without freeing state->port.xmit_buf. In
tty_port_open(), a non-zero return from port->ops->activate() causes an ear=
ly
return before tty_port_set_initialized(port, true) is called:

drivers/tty/tty_port.c:tty_port_open() {
	...
	if (!tty_port_initialized(port)) {
		clear_bit(TTY_IO_ERROR, &tty->flags);
		retval =3D port->ops->activate(port, tty);
		if (retval) {
			mutex_unlock(&port->mutex);
			return retval;
		}
		tty_port_set_initialized(port, true);
	}
	...
}

Because tty_port_initialized(port) remains false, neither
tty_port_shutdown_locked() on close nor serial_core_remove_one_port() on po=
rt
removal calls uart_shutdown() to free state->port.xmit_buf:

drivers/tty/serial/serial_core.c:serial_core_remove_one_port() {
	...
	scoped_guard(mutex, &port->mutex) {
		port->console =3D false;

		if (tty_port_initialized(port))
			uart_shutdown(NULL, state);
	}
	...
}

And when Driver::drop() later calls uart_unregister_driver(), drv->state is
freed without freeing state->port.xmit_buf.

> diff --git a/rust/kernel/serial/console.rs b/rust/kernel/serial/console.rs
> new file mode 100644
> index 0000000000000..3562191eb7a93
> --- /dev/null
> +++ b/rust/kernel/serial/console.rs
> @@ -0,0 +1,107 @@

[ ... ]

> +    /// # Safety
> +    ///
> +    /// Console core must hold console_list_lock and supply this driver'=
s live
> +    /// console. `options` must be null or a valid NUL-terminated option=
 string.
> +    pub(super) unsafe extern "C" fn console_setup(
> +        console: *mut bindings::console,
> +        options: *mut crate::ffi::c_char,
> +    ) -> i32 {
> +        // SAFETY: Console core holds console_list_lock; serial core has=
 published the port
> +        // before registering this console. uart_set_options calls our t=
ermios adapter.
> +        unsafe {
> +            let port =3D Self::console_port(console);
> +            if port.is_null() {
> +                return ENODEV.to_errno();
> +            }
> +            let mut baud =3D (*console).ispeed as i32;
> +            let (mut parity, mut bits, mut flow) =3D (i32::from(b'n'), 8=
, i32::from(b'n'));
> +            if !options.is_null() {
> +                bindings::uart_parse_options(options, &mut baud, &mut pa=
rity, &mut bits, &mut flow);
> +            }
> +            bindings::uart_set_options(port, console, baud, parity, bits=
, flow)
> +        }
> +    }

[Severity: Medium]
Can ConsoleAdapter::console_setup() and LockedPort::configure() lose
config.default_baud and overwrite console->ispeed and console->ospeed with =
0?

First, if non-null console options do not start with a positive baud rate,
uart_parse_options() calls simple_strtoul() and sets baud to 0, overwriting
the initial value read from (*console).ispeed rather than preserving
config.default_baud.

Second, uart_set_options() in drivers/tty/serial/serial_core.c constructs a
zeroed dummy ktermios and calls port->ops->set_termios(port, &termios, &dum=
my):

drivers/tty/serial/serial_core.c:uart_set_options() {
	struct ktermios termios, dummy;
	...
	memset(&termios, 0, sizeof(struct ktermios));
	memset(&dummy, 0, sizeof(struct ktermios));
	...
	port->ops->set_termios(port, &termios, &dummy);
	...
	co->cflag =3D termios.c_cflag;
	co->ispeed =3D termios.c_ispeed;
	co->ospeed =3D termios.c_ospeed;

	return 0;
}

When a driver's set_termios callback calls LockedPort::baud_rate() with an
out-of-range baud rate (or baud =3D=3D 0 from uart_parse_options()),
uart_get_baud_rate() falls back to the old termios (&dummy, which has baud
rate 0), encodes 0 into new.0, and clamps its return value to at least 9600.

When the driver then passes that non-zero baud rate to
LockedPort::configure(), the check:

    if bindings::tty_termios_baud_rate(&new.0) !=3D 0 {
        bindings::tty_termios_encode_baud_rate(&mut new.0, baud, baud);
    }

sees tty_termios_baud_rate(&new.0) =3D=3D 0 and skips encoding the actual b=
aud
rate into new.0. uart_set_options() then copies termios.c_ispeed (0) and
termios.c_ospeed (0) into co->ispeed and co->ospeed, so any subsequent
console_setup() or port resume reads (*console).ispeed =3D=3D 0 instead of
config.default_baud.

> diff --git a/rust/kernel/serial/termios.rs b/rust/kernel/serial/termios.rs
> new file mode 100644
> index 0000000000000..449662d9b6b5e
> --- /dev/null
> +++ b/rust/kernel/serial/termios.rs
> @@ -0,0 +1,104 @@

[ ... ]

> +    /// Whether parity generation and checking are enabled.
> +    pub fn parity_enabled(&self) -> bool {
> +        self.0.c_cflag & bindings::PARENB !=3D 0
> +    }
> +
> +    /// Whether odd parity, or mark parity in mark/space mode, is select=
ed.
> +    pub fn odd_parity(&self) -> bool {
> +        self.0.c_cflag & bindings::PARODD !=3D 0
> +    }
> +
> +    /// Whether two stop bits are requested.
> +    pub fn two_stop_bits(&self) -> bool {
> +        self.0.c_cflag & bindings::CSTOPB !=3D 0
> +    }
> +
> +    /// Disables mark/space parity without changing parity enable or odd=
/even selection.
> +    pub fn disable_mark_space_parity(&mut self) {
> +        self.0.c_cflag &=3D !bindings::CMSPAR;
> +    }
> +
> +    /// Disables RTS/CTS hardware flow control.
> +    pub fn disable_hardware_flow_control(&mut self) {
> +        self.0.c_cflag &=3D !bindings::CRTSCTS;
> +    }
> +
> +    /// Data bits per character.
> +    pub fn char_size(&self) -> u32 {
> +        // SAFETY: c_cflag is a valid termios control flag value.
> +        unsafe { bindings::tty_get_char_size(self.0.c_cflag).into() }
> +    }
> +}
> +
> +impl LockedPort<'_> {
> +    /// Selects a supported baud rate using serial-core termios rules.
> +    ///
> +    /// Returns `None` if serial core fails to select a rate. Termios ch=
anges
> +    /// made by serial core are preserved, including on failure.
> +    pub fn baud_rate(
> +        &self,
> +        new: &mut Termios,
> +        old: Option<&Termios>,
> +        min: u32,
> +        max: u32,
> +    ) -> Option<NonZeroU32> {
> +        // SAFETY: The port is locked, and the termios references are va=
lid for this callback.
> +        let baud =3D unsafe {
> +            bindings::uart_get_baud_rate(
> +                self.raw,
> +                &mut new.0,
> +                old.map_or(core::ptr::null(), |t| &t.0),
> +                min,
> +                max,
> +            )
> +        };
> +        NonZeroU32::new(baud)
> +    }
> +
> +    /// Updates serial-core timeout and the actual console baud rate.
> +    pub fn configure(&self, new: &mut Termios, baud: NonZeroU32) {
> +        let baud =3D baud.get();
> +        // SAFETY: All port fields are accessed under the UART lock. new=
 is exclusively borrowed.
> +        unsafe {
> +            bindings::uart_update_timeout(self.raw, new.0.c_cflag, baud);
> +            if bindings::tty_termios_baud_rate(&new.0) !=3D 0 {
> +                bindings::tty_termios_encode_baud_rate(&mut new.0, baud,=
 baud);
> +            }
> +        }
> +    }
> +}

[Severity: Low]
This isn't a bug, but should the small accessor methods and C binding
wrappers in the kernel crate (Termios::from_raw, Termios::from_raw_mut,
Termios::parity_enabled, Termios::odd_parity, Termios::two_stop_bits,
Termios::disable_mark_space_parity, Termios::disable_hardware_flow_control,
Termios::char_size, LockedPort::baud_rate, and LockedPort::configure here, =
as
well as Port::device and LockedPort::device in rust/kernel/serial.rs) be
annotated with #[inline]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D6
