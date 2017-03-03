From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: No output on console despite ignore_loglevel earlyprintk
Date: Fri, 3 Mar 2017 17:46:43 +0000
Message-ID: <20170303174643.GQ21222@n2100.armlinux.org.uk>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <20170303165548.GO21222@n2100.armlinux.org.uk>
 <3293964b-aec2-e8b8-46f5-49b0eacc4718@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3293964b-aec2-e8b8-46f5-49b0eacc4718@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 03, 2017 at 06:26:28PM +0100, Andreas F=E4rber wrote:
> Am 03.03.2017 um 17:55 schrieb Russell King - ARM Linux:
> > On Fri, Mar 03, 2017 at 05:42:02PM +0100, Marc Gonzalez wrote:
> >> I'm confused about early consoles and earlyprintk, and all that good s=
tuff.
> >> When my kernel panics, I don't get the expected output.
> >>
> >> Using "mem=3D256M ignore_loglevel earlyprintk"
> >>
> [...]
> >> [    0.014325] Console: colour dummy device 80x30
> >> [    0.018885] console [tty0] enabled
> >> [    0.022396] bootconsole [earlycon0] disabled
> >>
> >> And it hangs there.
> > =

> > tty0 is the kernel virtual terminal console, which is what appears on
> > VGA or framebuffers.  This is the default console if nothing else is
> > specified.
> > =

> > What happened here is that the virtual terminal console registered, was
> > detected to be the system console, so early console was shut down, and
> > the boot messages logged to the virtual terminal console instead.
> =

> Why does passing console=3D make a difference though?
> =

> I expect stdout-path to have the same effect as the command line, and I
> am pretty sure that that was previous behavior in, e.g., v4.4.
> =

> Note that I am using earlycon, as opposed to earlyprintk above.

The property is:

	stdout-path =3D "dt-node-name:hw-parameters";

and this is parsed by the code in drivers/of/fdt.c,
early_init_dt_scan_chosen_stdout() (briefly):

        offset =3D fdt_path_offset(fdt, "/chosen");
        p =3D fdt_getprop(fdt, offset, "stdout-path", &l);

        q =3D strchrnul(p, ':');
        if (*q !=3D '\0')
                options =3D q + 1;
        l =3D q - p;

        /* Get the node specified by stdout-path */
        offset =3D fdt_path_offset_namelen(fdt, p, l);
        if (offset < 0) {
                pr_warn("earlycon: stdout-path %.*s not found\n", l, p);

So here, offset points at the node named by "dt-node-name" above.

This function then tries to patch the specified node's compatible with
the drivers in the __earlycon_table:

        for (match =3D __earlycon_table; match < __earlycon_table_end; matc=
h++) {
                if (!match->compatible[0])
                        continue;

                if (fdt_node_check_compatible(fdt, offset, match->compatibl=
e))
                        continue;

and when a match is found, calls:

                of_setup_earlycon(match, offset, options);

Here, we go into the code in drivers/tty/serial/earlycon.c, which reads
the standard properties (like "reg", etc) filling out a uart_port
before calling the early console's ->setup method.  If everything goes
to plan, register_console() is called to register the early console.

So there's nothing there which changes the default system console.

The next place is of_alias_scan() in drivers/of/base.c.  This records
the device_node and options in of_stdout and of_stdout_options
respectively - it, again, does not change the default system console.

When a serial console is initialised, of_console_check() gets called by
serial core to check whether the DT node for it is "of_stdout", and if
it matches, it modifies the preferred system console.

This all looks good, and one might expect that it has the desired
effect, but this code is fatally flawed in design: the point at which
of_console_check() gets called is _way_ after consoles like the virtual
terminal console get initialised.  What this means is that, at the point
in time that the virtual terminal is initialised, as far as the console
system is concerned, the preferred console is still the virtual terminal.
It knows nothing about the desire for a different console.

Given the current console handling, it's not easy to solve without
overhauling the way consoles are chosen - the root problem is that the
Linux console system works via Linux device driver names and indexes,
and there's no easy way to translate a DT stdout-path property to a
Linux device driver name and index without the driver having been
initialised.

-- =

RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
