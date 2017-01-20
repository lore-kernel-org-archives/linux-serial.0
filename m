From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/9] Serial slave device bus
Date: Fri, 20 Jan 2017 14:55:20 +0100
Message-ID: <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
References: <20170116225436.17505-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 16, 2017 at 11:54 PM, Rob Herring <robh@kernel.org> wrote:

> There's still some discussion about what to do with devices that pass thr=
u
> data to userspace unmodified like GPS and could still use tty device for
> the data path. IMO, we should treat this as a separate problem following
> this series. Drivers we want to convert to serdev and already in the
> kernel don't need this functionality.

In my simple opinion GPSes shound live in drivers/iio/gps simply by
usecase association: streaming out a series of accelerometer readings
periodically through IIOs chardevs and other data about the physical
world is not any different from the GPS usecase that give you a stream
of coordinates on where on this planet you are.

The fact that vendors like to defer GPS processing to userspace because
it is considered "secret sauce" is not the concern of the kernel community,
though problems like that in general is the great tragedy of our time.

It would be fun to see a pure, reverse-engineered GPS driver in IIO.

Just my =E2=82=AC0.01

(And by the way: awesome work on this series.)

Yours,
Linus Walleij
