From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] Alsa mixer over serial port
Date: Thu, 02 Jul 2009 15:27:43 +0200
Message-ID: <4A4CB5CF.2020703@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

I'm currently working on ASoC driver for a voice modem codec chip 
(Conexant CX20442) available on ARM OMAP amsdelta board. The driver 
should provide some controls for switching audio path from handset to 
speakerphone and back, changing volume etc.

The only way of controlling some aspects of the codec that I know of is 
over an acompanying voice modem chip (CX81801) with AT voice commands. 
The modem can be accessed over a platform serial device.

I can see two ways of getting this working:
1) add a new line discipline that would take control over the serial 
line and convert it to an alsa mixer,
2) create a low level driver that would replace standard serial stuff 
completely (like snd-serial-u16550 does, for example).

Please advise which one is better.

Thanks,
Janusz
