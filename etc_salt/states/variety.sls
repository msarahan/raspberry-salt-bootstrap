variety-prereqs:
  pkg.installed:
   - pkgs:
     - bzr
     - gir1.2-appindicator3-0.1
     - gir1.2-gdkpixbuf-2.0
     - gir1.2-glib-2.0
     - gir1.2-gtk-2.0
     - gir1.2-notify-0.7
     - gir1.2-pango-1.0
     - gir1.2-webkit-3.0
     - imagemagick
     - python-bs4
     - python-cairo
     - python-configobj
     - python-dbus
     - python-imaging
     - python-lxml
     - python-pycurl
     - python-pyexiv2
     - yelp

variety-checkout:
  cmd.run:
    - name: bzr branch lp:variety
    - cwd: /home/pi
  file.managed:
    - name: /home/pi/.config/variety/variety.conf
    - makedirs: True
    - source: salt://variety/variety.conf
  require:
    - pkg: variety-prereqs

variety-permissions:
  cmd.run:
    - name: chown -R pi:users /home/pi
  require:
    - pkg: variety-checkout

variety-run:
  pkg.installed:
    - pkgs:
      - supervisor
  file.managed:
    - name: /etc/supervisor/conf.d/variety.conf
    - source: salt://variety/supervisord.conf

supervisor-start-variety:
  file.managed:
    - name: /home/pi/.config/autostart/supervisord.desktop
    - source: salt://variety/supervisord.desktop
    - user: pi
    - group: users

unclutter:
  pkg.installed:
    - pkgs:
      - unclutter
  file.managed:
    - name: /home/pi/.config/autostart/unclutter.desktop
    - source: salt://variety/unclutter.desktop
    - user: pi
    - group: users

disable_screensaver:
  file.managed:
    - name: /etc/xdg/lxsession/LXDE-pi/autostart
    - source: salt://variety/lxde-pi_autostart

panel:
  file.managed:
    - name: /home/pi/.config/lxpanel/LXDE-pi/panels/panel
    - source: salt://variety/panel
    - user: pi
    - group: users
    
